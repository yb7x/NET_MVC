using HPIT.RentHouse.Common;
using Qiniu.Http;
using Qiniu.Storage;
using Qiniu.Util;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;


/// <summary>
/// UploadHandler 的摘要说明
/// </summary>
public class UploadHandler : Handler
{

    public UploadConfig UploadConfig { get; private set; }
    public UploadResult Result { get; private set; }

    public UploadHandler(HttpContext context, UploadConfig config)
        : base(context)
    {
        this.UploadConfig = config;
        this.Result = new UploadResult() { State = UploadState.Unknown };
    }

    public override void Process()
    {
        byte[] uploadFileBytes = null;
        string uploadFileName = null;
        HttpPostedFile file = null;

        if (UploadConfig.Base64)
        {
            uploadFileName = UploadConfig.Base64Filename;
            uploadFileBytes = Convert.FromBase64String(Request[UploadConfig.UploadFieldName]);
        }
        else
        {
            file = Request.Files[UploadConfig.UploadFieldName];
            uploadFileName = file.FileName;

            if (!CheckFileType(uploadFileName))
            {
                Result.State = UploadState.TypeNotAllow;
                WriteResult();
                return;
            }
            if (!CheckFileSize(file.ContentLength))
            {
                Result.State = UploadState.SizeLimitExceed;
                WriteResult();
                return;
            }

            uploadFileBytes = new byte[file.ContentLength];
            try
            {
                file.InputStream.Read(uploadFileBytes, 0, file.ContentLength);
            }
            catch (Exception)
            {
                Result.State = UploadState.NetworkError;
                WriteResult();
            }
        }

        Result.OriginFileName = uploadFileName;

        //#region 旧代码
        //var savePath = PathFormatter.Format(uploadFileName, UploadConfig.PathFormat);
        //var localPath = Server.MapPath(savePath);
        //try
        //{
        //    if (!Directory.Exists(Path.GetDirectoryName(localPath)))
        //    {
        //        Directory.CreateDirectory(Path.GetDirectoryName(localPath));
        //    }
        //    File.WriteAllBytes(localPath, uploadFileBytes);
        //    Result.Url = savePath;
        //    Result.State = UploadState.Success;
        //}
        //catch (Exception e)
        //{
        //    Result.State = UploadState.FileAccessError;
        //    Result.ErrorMessage = e.Message;
        //}
        //finally
        //{
        //    WriteResult();
        //}
        //#endregion

        #region 利用七牛云代替
        try
        {
            string AccessKey = "OTpJSqbyNELXDbtQmuMp2LQ4titn_2S7RO1iz99s";
            string SecretKey = "3SkH1Y_Oyjwi8FKpetMZw6b5DBglTa5zJWDwnral";
            String Bucket = "hpitzszqqq";//存储空间的名字


            Mac mac = new Mac(AccessKey, SecretKey);
            Random rand = new Random();
            //string key = "ok.jpg";
            //string filePath = "1.jpg";


            string md5 = CommonHelper.CalcMD5(uploadFileBytes);//生成文件的md5
            string ext = Path.GetExtension(Result.OriginFileName);//获取文件的扩展名
            string key = "upload/" + DateTime.Now.ToString("yyyy/MM/dd") + "/" + md5 + ext;

            PutPolicy putPolicy = new PutPolicy();
            putPolicy.Scope = Bucket + ":" + key; //指定上传的目标资源空间Bucket  允许用户上传指定key的文件。在这种格式下文件默认允许修改，若已存在同名资源则会被覆盖
            putPolicy.SetExpires(3600);  //上传策略的过期时间(单位:秒)
            putPolicy.DeleteAfterDays = 1;//文件上传完毕后，在多少天后自动被删除
            string token = Auth.CreateUploadToken(mac, putPolicy.ToJsonString());

            Qiniu.Storage.Config config = new Qiniu.Storage.Config();
            config.Zone = Zone.ZONE_CN_North;// 设置上传区域
            config.UseHttps = true;// 设置 http 或者 https 上传
            config.UseCdnDomains = true;
            config.ChunkSize = ChunkUnit.U512K;
            ResumableUploader target = new ResumableUploader(config);
            //HttpResult result = target.UploadFile(filePath, key, token, null);

            HttpResult result = target.UploadStream(file.InputStream, key, token, null);
            Result.Url = key;
            Result.State = UploadState.Success;
        }
        catch (Exception e)
        {

            Result.State = UploadState.FileAccessError;
            Result.ErrorMessage = e.Message;
        }

        finally
        {
            WriteResult();
        }

        #endregion
    }

    private void WriteResult()
    {
        this.WriteJson(new
        {
            state = GetStateMessage(Result.State),
            url = Result.Url,
            title = Result.OriginFileName,
            original = Result.OriginFileName,
            error = Result.ErrorMessage
        });
    }

    private string GetStateMessage(UploadState state)
    {
        switch (state)
        {
            case UploadState.Success:
                return "SUCCESS";
            case UploadState.FileAccessError:
                return "文件访问出错，请检查写入权限";
            case UploadState.SizeLimitExceed:
                return "文件大小超出服务器限制";
            case UploadState.TypeNotAllow:
                return "不允许的文件格式";
            case UploadState.NetworkError:
                return "网络错误";
        }
        return "未知错误";
    }

    private bool CheckFileType(string filename)
    {
        var fileExtension = Path.GetExtension(filename).ToLower();
        return UploadConfig.AllowExtensions.Select(x => x.ToLower()).Contains(fileExtension);
    }

    private bool CheckFileSize(int size)
    {
        return size < UploadConfig.SizeLimit;
    }
}

public class UploadConfig
{
    /// <summary>
    /// 文件命名规则
    /// </summary>
    public string PathFormat { get; set; }

    /// <summary>
    /// 上传表单域名称
    /// </summary>
    public string UploadFieldName { get; set; }

    /// <summary>
    /// 上传大小限制
    /// </summary>
    public int SizeLimit { get; set; }

    /// <summary>
    /// 上传允许的文件格式
    /// </summary>
    public string[] AllowExtensions { get; set; }

    /// <summary>
    /// 文件是否以 Base64 的形式上传
    /// </summary>
    public bool Base64 { get; set; }

    /// <summary>
    /// Base64 字符串所表示的文件名
    /// </summary>
    public string Base64Filename { get; set; }
}

public class UploadResult
{
    public UploadState State { get; set; }
    public string Url { get; set; }
    public string OriginFileName { get; set; }

    public string ErrorMessage { get; set; }
}

public enum UploadState
{
    Success = 0,
    SizeLimitExceed = -1,
    TypeNotAllow = -2,
    FileAccessError = -3,
    NetworkError = -4,
    Unknown = 1,
}

