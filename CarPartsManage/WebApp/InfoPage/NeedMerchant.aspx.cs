using RL.DBUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApp.InfoPage
{
    public partial class NeedMerchant : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();
            }
        }
        public void BindData()
        {
            //查询数据并绑定显示
            string sql = "SELECT Id,IsDeliver,Num,Name,Principal,Address,Phone FROM NeedMerchant;";
            DataSet ds = DbHelperSQL.Query(sql);
            gvNeedMer.DataSource = ds;
            gvNeedMer.DataBind();

        }

        protected void gvSupplies_PageIndexChanging(object sender, GridViewPageEventArgs e)
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
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            StringBuilder sbIds = new StringBuilder();
            //获取gridview里的checkbox是否被选中
            foreach (GridViewRow gvr in gvNeedMer.Rows)
            {
                CheckBox cbSelection = gvr.FindControl("cbSelection") as CheckBox;
                if (cbSelection.Checked)
                {
                    sbIds.Append(gvNeedMer.DataKeys[gvr.RowIndex]["Id"] + ",");
                }
            }
            //todo Delete From Table Where ID IN (1,2,3,4..)
            sbIds.Remove(sbIds.Length - 1, 1);//移除最后一个逗号
            //判断选中了一个，还是选中了多个进行删除
            if (sbIds.Length - 1 > 1)
            {
                sbIds.Insert(0, "DELETE FROM dbo.Supplies WHERE Id in (");
                sbIds.Insert(sbIds.Length, ")");
            }
            else
            {
                sbIds.Insert(0, "DELETE FROM dbo.Supplies WHERE Id = ");
            }
            DbHelperSQL.ExecuteSql(sbIds.ToString());
            Response.Write("<script>alert('删除成功');</script>");
            Response.Redirect("NeedMerchant.aspx");
        }
    }
}