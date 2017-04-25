using RL.DBUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.SessionState;
namespace WebApp
{
    /// <summary>
    /// LoginHandler 的摘要说明
    /// </summary>
    public class LoginHandler : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //获取用户名和密码
            string name = context.Request["name"];
            string password = context.Request["password"];
            //获取数据库数据，放置在ds中
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("SELECT TOP 1 UserId,UserName,Password,Type,LoginTime,Department ");
            sb.AppendLine("FROM Users");
            sb.AppendLine("WHERE UserName = @UserName AND Password = @Password; ");
            SqlParameter[] pms = { 
                                    new SqlParameter("@UserName",SqlDbType.NVarChar,50),
                                    new SqlParameter("@Password",SqlDbType.NVarChar,50)
                                 };
            pms[0].Value = name;
            pms[1].Value = password;
            DataSet ds = DbHelperSQL.Query(sb.ToString(),pms);
            //判断表中是否存在数据，如果有数据则登录成功，如果没有数据，则登录失败
            if (ds.Tables[0].Rows.Count > 0)
            {
                //根据判断选择进入哪个主页,无论进来的管理员或者是普通用户都记录下操作者的ID，方便记录日志
                if (ds.Tables[0].Rows[0]["Type"].ToString() == "1")
                {
                    context.Session["Id"] = ds.Tables[0].Rows[0]["UserId"].ToString();
                    context.Session["LoginTime"] = DateTime.Now.ToString();
                    context.Response.Write("ok1:登录成功");
                }
                else
                {
                    context.Session["Id"] = ds.Tables[0].Rows[0]["UserId"].ToString();
                    context.Session["LoginTime"] = DateTime.Now.ToString();
                    context.Response.Write("ok2:登录成功");
                }
            }
            //验证失败弹出提示框
            else
            {
                context.Response.Write("用户名或密码错误，请重新登录");
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}