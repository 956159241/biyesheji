using RL.DBUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApp
{
    public partial class Index2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();
            }
        }
        //绑定gvParts和gvNeed
        public void BindData()
        {
            //查询数据
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("SELECT C.PartId,C.Num,C.PartName,S.Name,C.InTime,C.Quantity,C.UnitPrice");
            sb.AppendLine("FROM CarParts AS C INNER JOIN Supplies AS S");
            sb.AppendLine("ON C.FromDepartId = S.Id;");
            DataSet ds = DbHelperSQL.Query(sb.ToString());
            //将数据绑定到gvParts上展示
            gvParts.DataSource = ds.Tables[0];
            gvParts.DataBind();
            //查询数据并绑定显示，绑定需求商表
            string sql = "SELECT Id,IsDeliver,Num,Name,Principal,Address,Phone FROM NeedMerchant;";
            DataSet dsNeed = DbHelperSQL.Query(sql);
            gvNeedMer.DataSource = dsNeed;
            gvNeedMer.DataBind();
        }
        //分页
        protected void gvParts_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            // 得到该控件
            GridView theGrid = sender as GridView;
            int newPageIndex = 0;
            if (e.NewPageIndex == -3)
            {
                //点击了Go按钮
                TextBox txtNewPageIndex = null;

                //GridView较DataGrid提供了更多的API，获取分页块可以使用BottomPagerRow 或者TopPagerRow，当然还增加了HeaderRow和FooterRow
                GridViewRow pagerRow = theGrid.BottomPagerRow;

                if (pagerRow != null)
                {
                    //得到text控件
                    txtNewPageIndex = pagerRow.FindControl("txtNewPageIndex") as TextBox;
                }
                if (txtNewPageIndex != null)
                {
                    //得到索引
                    newPageIndex = int.Parse(txtNewPageIndex.Text) - 1;
                }
            }
            else
            {
                //点击了其他的按钮
                newPageIndex = e.NewPageIndex;
            }
            //防止新索引溢出
            newPageIndex = newPageIndex < 0 ? 0 : newPageIndex;
            newPageIndex = newPageIndex >= theGrid.PageCount ? theGrid.PageCount - 1 : newPageIndex;

            //得到新的值
            theGrid.PageIndex = newPageIndex;

            //重新绑定
            BindData();
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            //为操作日志做好准备
            //获取输入编号数量和出库方向
            string Num = txtNum.Text;
            int Quantity = Convert.ToInt32(txtQuantity.Text);
            string NeederNum = txtNeedMerchant.Text;
            //根据写入的编号获取配件的名称
            string sqlGetPName = "Select PartName from CarParts where Num = @Num;";
            SqlParameter[] pmsGetPName = { 
                                        new SqlParameter("@Num",SqlDbType.NVarChar,50),
                                     };
            pmsGetPName[0].Value = Num;
            DataSet dsGetPName = DbHelperSQL.Query(sqlGetPName, pmsGetPName);
            string pName = dsGetPName.Tables[0].Rows[0]["PartName"].ToString();
            
            //根据写入的编号获取需求商的名称
            string nName = "";
            if (NeederNum != "")
            {
                string sqlGetNName = "Select Name from NeedMerchant where Num = @Num;";
                SqlParameter[] pmsGetNName = { 
                                        new SqlParameter("@Num",SqlDbType.NVarChar,50),
                                     };
                pmsGetNName[0].Value = NeederNum;
                DataSet dsGetNName = DbHelperSQL.Query(sqlGetNName, pmsGetNName);
                nName = dsGetNName.Tables[0].Rows[0]["Name"].ToString();
            }

            //获取用户登录的Id，并获取登录用户的相关信息
            int id = Convert.ToInt32(Session["Id"]);
            DateTime date = Convert.ToDateTime(Session["LoginTime"]);
            if (id == 0) 
            {
                id = 2;
            }
            string sqlUsers = "Select UserName,Department from Users where UserId = @id;";
            SqlParameter[] pms = { 
                                        new SqlParameter("@id",SqlDbType.Int),
                                     };
            pms[0].Value = id;
            DataSet ds = DbHelperSQL.Query(sqlUsers,pms);
            string type = ddlType.SelectedValue;
            //插入日志列表
            string sqlInsertLog = "insert into Log(Operator,Department,Type,Details,Time,IP)" +
                " Values(@Operator,@Department,@Type,@Details,getDate(),@IP)";
            SqlParameter[] pmsInsertLog = { 
                                          new SqlParameter("@Operator",SqlDbType.NVarChar,50),
                                          new SqlParameter("@Department",SqlDbType.NVarChar,50),
                                          new SqlParameter("@Type",SqlDbType.NVarChar,50),
                                          new SqlParameter("@Details",SqlDbType.NVarChar,50),
                                          new SqlParameter("@IP",SqlDbType.NVarChar,50)
                                          };
            pmsInsertLog[0].Value = ds.Tables[0].Rows[0]["UserName"];
            pmsInsertLog[1].Value = ds.Tables[0].Rows[0]["Department"];
            pmsInsertLog[2].Value = type;
            if (type == "入库")
            {
                pmsInsertLog[3].Value = Num + pName + type + Quantity + "件";
            }
            else
            {
                pmsInsertLog[3].Value = Num + pName + type + "至" + nName + Quantity + "件";
            }
            pmsInsertLog[4].Value = GetIP();
            DbHelperSQL.ExecuteSql(sqlInsertLog,pmsInsertLog);
            //根据下拉选择不同，有出库和入库两个选择，然后进行不同的操作
            //入库操作
           
            if (ddlType.SelectedValue == "入库")
            { 
                //更改数据库数据
                string sql = "update CarParts set Quantity = Quantity + @Quantity where Num = @Num";
                SqlParameter[] pms2 = { 
                                        new SqlParameter("@Quantity",SqlDbType.Int),
                                        new SqlParameter("@Num",SqlDbType.NVarChar,50)
                                     };
                pms2[0].Value = Quantity;
                pms2[1].Value = Num;
                DbHelperSQL.ExecuteSql(sql,pms2);
                //插入操作日志

                Response.Redirect("Index2.aspx");
            }
            //出库操作
            else
            {
                string sql = "update CarParts set Quantity = Quantity - @Quantity where Num = @Num";
                SqlParameter[] pms1 = { 
                                        new SqlParameter("@Quantity",SqlDbType.Int),
                                        new SqlParameter("@Num",SqlDbType.NVarChar,50)
                                     };
                pms1[0].Value = Quantity;
                pms1[1].Value = Num;
                DbHelperSQL.ExecuteSql(sql, pms1);
                //更改需求商的是否发货状态
                string sqlUpdate = "update NeedMerchant set IsDeliver = 'True' where Num = @NeedNum;";
                SqlParameter[] pars = { 
                                        new SqlParameter("@NeedNum",SqlDbType.NVarChar,50)
                                     };
                pars[0].Value = NeederNum;
                DbHelperSQL.ExecuteSql(sqlUpdate,pars);
                Response.Redirect("Index2.aspx");
            }
        }
        //获取Ip
        public string GetIP()
        {
            string result = String.Empty;
            result = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            if (string.IsNullOrEmpty(result))
            {
                result = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
            }
            if (string.IsNullOrEmpty(result))
            {
                result = HttpContext.Current.Request.UserHostAddress;
            }
            if (string.IsNullOrEmpty(result))
            {
                return "127.0.0.1";
            }
            return result;
        }
    }
}