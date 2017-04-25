using RL.DBUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace WebApp.Scripts
{
    /// <summary>
    /// Index2Handler 的摘要说明
    /// </summary>
    public class Index2Handler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            int quantity = Convert.ToInt32(context.Request["quantity"]);
            int id = Convert.ToInt32(context.Request["id"]);
            //数据更新
            string sqlUpdate = "UPDATE CarParts SET Quantity = Quantity + @Quantity WHERE PartId = @id";
            SqlParameter[] pms = { 
                                    new SqlParameter("@Quantity",SqlDbType.Int),
                                    new SqlParameter("@id",SqlDbType.Int)
                                 };
            pms[0].Value = quantity;
            pms[1].Value = id;
            DbHelperSQL.ExecuteSql(sqlUpdate,pms);
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