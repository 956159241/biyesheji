using RL.DBUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApp.InfoPage
{
    public partial class ManagerEdit : System.Web.UI.Page
    {
        private int uId = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            //根据有无传递参数显示表格内容
            if (Request.QueryString.AllKeys.Contains("uid"))
            {
                uId = int.Parse(Request.QueryString["uid"]);
            }
            if (!IsPostBack)
            {
                if (uId != 0)
                {
                    ShowInfo(uId);
                }
            }
        }
        public void ShowInfo(int id)
        {

            StringBuilder sbSql = new StringBuilder();
            sbSql.AppendLine("SELECT UserId,UserName,Department");
            sbSql.AppendLine("FROM Users WHERE UserId = @Id");
            SqlParameter[] pars = { 
                                  new SqlParameter("@Id",SqlDbType.Int)
                                  };
            pars[0].Value = id;
            DataSet ds = DbHelperSQL.Query(sbSql.ToString(), pars);
            txtUserName.Text = ds.Tables[0].Rows[0]["UserName"].ToString();
            txtPassword.Text = ds.Tables[0].Rows[0]["Password"].ToString();
            txtDepartment.Text = ds.Tables[0].Rows[0]["Department"].ToString();
            btnAdd.Text = "修改";

        }
        //添加数据
        protected void btnAdd_Click(object sender, EventArgs e)
        {

            //获取输入值
            string UserName = txtUserName.Text.ToString();
            string Password = txtPassword.Text.ToString();
            string Department = txtDepartment.Text.ToString();
            //由于带参数进入后，将按钮的文字改变了，所以可以根据文字不同进行不同的操作
            if (btnAdd.Text == "添加")
            {
               
                StringBuilder sb = new StringBuilder();
                sb.AppendLine("INSERT INTO Users(UserName,Password,Department,LoginTime,Type)");
                sb.AppendLine("VALUES(@UserName,@Password,@Department,GetDate(),'2');");
                SqlParameter[] pms = { 
                                    new SqlParameter("@UserName",SqlDbType.NVarChar,50),
                                    new SqlParameter("@Password",SqlDbType.NVarChar,50),
                                    new SqlParameter("@Department",SqlDbType.NVarChar,50)
                                     };
                pms[0].Value = UserName;
                pms[1].Value = Password;
                pms[2].Value = Department;
                DbHelperSQL.ExecuteSql(sb.ToString(), pms);
            }
            else
            {
                uId = int.Parse(Request.QueryString["uid"]);
                StringBuilder sbUpdate = new StringBuilder();
                sbUpdate.AppendLine("UPDATE Users SET");
                sbUpdate.AppendLine("UserName = @UserName, Password = @Password,Department = @Department");
                sbUpdate.AppendLine("WHERE UserId = @UserId;");
                SqlParameter[] pars = { 
                                    new SqlParameter("@UserName",SqlDbType.NVarChar,50),
                                    new SqlParameter("@Password",SqlDbType.NVarChar,50),
                                    new SqlParameter("@Department",SqlDbType.NVarChar,50),
                                    new SqlParameter("@UserId",SqlDbType.Int)
                                 };
                pars[0].Value = UserName;
                pars[1].Value = Password;
                pars[2].Value = Department;
                pars[6].Value = uId;
                DbHelperSQL.ExecuteSql(sbUpdate.ToString(), pars);
            }
            Response.Write("<script language=\"javascript\">opener.location.href=opener.location.href;opener=null;window.close();</script>");

        }
    }
}