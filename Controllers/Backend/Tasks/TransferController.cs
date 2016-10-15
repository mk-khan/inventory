﻿using System;
using System.Net;
using System.Threading.Tasks;
using System.Web.Mvc;
using Frapid.ApplicationState.Cache;
using Frapid.Dashboard;
using MixERP.Inventory.DAL.Backend.Service;
using MixERP.Inventory.DAL.Backend.Tasks;
using MixERP.Inventory.ViewModels;

namespace MixERP.Inventory.Controllers.Backend.Tasks
{
    public class TransferController : InventoryBackendController
    {
        [Route("dashboard/inventory/tasks/inventory-transfers")]
        [MenuPolicy]
        public ActionResult Index()
        {
            return this.FrapidView(this.GetRazorView<AreaRegistration>("Tasks/Transfer/Index.cshtml", this.Tenant));
        }

        [Route("dashboard/inventory/tasks/transfers/checklist/{tranId}")]
        [MenuPolicy(OverridePath = "/dashboard/inventory/tasks/inventory-transfers")]
        public ActionResult CheckList(long tranId)
        {
            return this.FrapidView(this.GetRazorView<AreaRegistration>("Tasks/Transfer/Checklist.cshtml", this.Tenant), tranId);
        }

        [Route("dashboard/inventory/tasks/inventory-transfers")]
        [HttpPost]
        public async Task<ActionResult> PostAsync(InventoryTransfer model)
        {
            if (!this.ModelState.IsValid)
            {
                return this.InvalidModelState();
            }

            var meta = await AppUsers.GetCurrentAsync().ConfigureAwait(true);
            model.OfficeId = meta.OfficeId;
            model.UserId = meta.UserId;
            model.LoginId = meta.LoginId;

            foreach (var item in model.Details)
            {
                if (item.TransferTypeEnum == TransferTypeEnum.Cr)
                {
                    decimal existingQuantity = await Items.CountItemsByItemCodeAsync(this.Tenant, item.ItemCode,
                        item.UnitName, item.StoreName).ConfigureAwait(true);

                    if (existingQuantity < item.Quantity)
                    {
                        return this.Failed($"We only have {existingQuantity} {item.UnitName} in inventory",
                            HttpStatusCode.InternalServerError);
                    }
                }
            }

            try
            {
                long id = await InventoryTransfers.AddAsync(this.Tenant, model).ConfigureAwait(true);
                return this.Ok(id);
            }
            catch (Exception ex)
            {
                return this.Failed(ex.Message, HttpStatusCode.InternalServerError);
            }
        }

        [Route("dashboard/inventory/tasks/inventory-transfers/new")]
        [MenuPolicy(OverridePath = "/dashboard/inventory/tasks/inventory-transfers")]
        public ActionResult New()
        {
            return this.FrapidView(this.GetRazorView<AreaRegistration>("Tasks/Transfer/New.cshtml", this.Tenant));
        }
    }
}