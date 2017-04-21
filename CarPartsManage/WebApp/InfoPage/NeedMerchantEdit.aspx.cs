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
    public partial class NeedMerchantEdit : System.Web.UI.Page
    {
        private int nId = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            //根据有无传递参数显示表格内容
            if (Request.QueryString.AllKeys.Contains("nid"))
            {
                nId = int.Parse(Request.QueryString["nid"]);
            }
            if (!IsPostBack)
            {
                if (nId != 0)
                {
                    ShowInfo(nId);
                }
            }
        }
        public void ShowInfo(int id)
        {

            StringBuilder sbSql = new StringBuilder();
            sbSql.AppendLine("SELECT S.Id,S.Num,S.Name,S.Principal,S.Address,S.Ways,S.Phone");
            sbSql.AppendLine("FROM Supplies AS S");
            DataSet ds = DbHelperSQL.Query(sbSql.ToString());

            txtNum.Text = ds.Tables[0].Rows[0]["Num"].ToString();
            txtPrincipal.Text = ds.Tables[0].Rows[0]["Principal"].ToString();
            txtName.Text = ds.Tables[0].Rows[0]["Name"].ToString();
            txtAddress.Text = ds.Tables[0].Rows[0]["Address"].ToString();
            txtPhone.Text = ds.Tables[0].Rows[0]["Phone"].ToString();
            btnAdd.Text = "修改";

        }
        //添加数据
        protected void btnAdd_Click(object sender, EventArgs e)
        {

            //获取输入值
            string Num = txtNum.Text;
            string Name = txtName.Text;
            string Principle = txtPrincipal.Text;
            string Address = txtAddress.Text;
            string Phone = txtPhone.Text;

            //由于带参数进入后，将按钮的文字改变了，所以可以根据文字不同进行不同的操作
            if (btnAdd.Text == "添加")
            {
                StringBuilder sb = new StringBuilder();
                sb.AppendLine("INSERT INTO NeedMerchant(Num,Name,Principal,Address,Phone,IsDeliver)");
                sb.AppendLine("VALUES(@Num,@Name,@Principal,@Address,@Phone,'False');");
                SqlParameter[] pms = { 
                                    new SqlParameter("@Num",SqlDbType.NVarChar,50),
                                    new SqlParameter("@Name",SqlDbType.NVarChar,50),
                                    new SqlParameter("@Principal",SqlDbType.NVarChar,50),
                                    new SqlParameter("@Address",SqlDbType.NVarChar,50),
                                    new SqlParameter("@Phone",SqlDbType.NVarChar,50)
                                 };
                pms[0].Value = Num;
                pms[1].Value = Name;
                pms[2].Value = Principle;
                pms[3].Value = Address;
                pms[4].Value = Phone;
                DbHelperSQL.ExecuteSql(sb.ToString(), pms);
            }
            else
            {
                nId = int.Parse(Request.QueryString["sid"]);
                StringBuilder sbUpdate = new StringBuilder();
                sbUpdate.AppendLine("UPDATE Supplies SET");
                sbUpdate.AppendLine("Num = @Num, Name = @Name,Principal = @Principal,");
                sbUpdate.AppendLine(" Address = @Address,Phone = @Phone");
                sbUpdate.AppendLine("WHERE Id = @Id;");
                SqlParameter[] pars = { 
                                     new SqlParameter("@Num",SqlDbType.NVarChar,50),
                                    new SqlParameter("@Name",SqlDbType.NVarChar,50),
                                    new SqlParameter("@Principal",SqlDbType.NVarChar,50),
                                    new SqlParameter("@Address",SqlDbType.NVarChar,50),
                                    new SqlParameter("@Phone",SqlDbType.NVarChar,50),
                                    new SqlParameter("@Id",SqlDbType.Int)
                                 };
                pars[0].Value = Num;
                pars[1].Value = Name;
                pars[2].Value = Principle;
                pars[3].Value = Address;
                pars[4].Value = Phone;
                pars[5].Value = nId;
                DbHelperSQL.ExecuteSql(sbUpdate.ToString(), pars);
            }
            Response.Write("<script language=\"javascript\">opener.location.href=opener.location.href;opener=null;window.close();</script>");

        }
    }
}