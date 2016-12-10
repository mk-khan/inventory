﻿#pragma warning disable 1591
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ASP
{
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Linq;
    using System.Net;
    using System.Text;
    using System.Web;
    using System.Web.Helpers;
    using System.Web.Mvc;
    using System.Web.Mvc.Ajax;
    using System.Web.Mvc.Html;
    using System.Web.Routing;
    using System.Web.Security;
    using System.Web.UI;
    using System.Web.WebPages;
    using Frapid.Configuration;
    using Frapid.Dashboard;
    using Frapid.DataAccess;
    using Frapid.DbPolicy;
    using Frapid.Framework;
    using Frapid.i18n;
    using Frapid.Messaging;
    using Frapid.Mapper.Decorators;
    using Frapid.WebsiteBuilder;
    using MixERP.Inventory;
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("RazorGenerator", "2.0.0.0")]
    [System.Web.WebPages.PageVirtualPathAttribute("~/Views/Setup/Variants.cshtml")]
    public partial class _Views_Setup_Variants_cshtml : System.Web.Mvc.WebViewPage<dynamic>
    {
        public _Views_Setup_Variants_cshtml()
        {
        }
        public override void Execute()
        {
            
            #line 3 "..\..\Views\Setup\Variants.cshtml"
  
    ViewBag.Title = "Variants";
    Layout = ViewBag.Layout;

            
            #line default
            #line hidden
WriteLiteral(@"

<script>
    var scrudFactory = new Object();

    scrudFactory.title = ""Variants"";

    scrudFactory.viewAPI = ""/api/forms/inventory/variants"";
    scrudFactory.viewTableName = ""inventory.variants"";

    scrudFactory.formAPI = ""/api/forms/inventory/variants"";
    scrudFactory.formTableName = ""inventory.variants"";

    scrudFactory.excludedColumns = [""audit_user_id"", ""audit_ts""];

    scrudFactory.allowDelete = true;
    scrudFactory.allowEdit = true;

    scrudFactory.live = ""VariantName"";

    scrudFactory.card = {
        header: ""variant_name"",
        meta: ""attribute_id"",
        description: ""attribute_value""        
    };

    //scrudFactory.layout = [
    //    {
    //        tab: """",
    //        fields: [
    //            ["""", """"],
    //            ["""", """"],
    //        ]
    //    }
    //];

    scrudFactory.keys = [
        {
            property: ""AttributeId"",
            url: '/api/forms/inventory/attributes/display-fields',
            data: null,
            valueField: ""Key"",
            textField: ""Value""
        }
    ];



    $.get('/ScrudFactory/View.html', function (view) {
        $.get('/ScrudFactory/Form.html', function (form) {
            $(""#ScrudFactoryView"").html(view);
            $(""#ScrudFactoryForm"").html(form);
            $.cachedScript(""/assets/js/scrudfactory-view.js"");
            $.cachedScript(""/assets/js/scrudfactory-form.js"");
        });
    });
</script>

<div");

WriteLiteral(" id=\"ScrudFactoryForm\"");

WriteLiteral("></div>\r\n<div");

WriteLiteral(" id=\"ScrudFactoryView\"");

WriteLiteral("></div>");

        }
    }
}
#pragma warning restore 1591