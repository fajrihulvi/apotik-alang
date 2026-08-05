
<?php $purchase_js = FCPATH.'my-assets/js/admin_js/purchase.js'; $purchase_js_ver = (file_exists($purchase_js) ? filemtime($purchase_js) : '1'); ?>
<script src="<?php echo base_url()?>my-assets/js/admin_js/purchase.js?v=<?php echo $purchase_js_ver; ?>" type="text/javascript"></script>

<style>
/* Tabel pembelian punya banyak kolom. Beri lebar minimum supaya kolom
   tidak saling menghimpit; bila layar sempit, pembungkus .table-responsive
   yang menyediakan geser mendatar. */
#purchaseTable { min-width: 1100px; }

/* Kolom Total menampung input diskon keseluruhan beserta dropdown
   satuan (% / nominal), jadi butuh ruang lebih lebar. */
#purchaseTable .col-total { min-width: 210px; }

/* Kotak diskon keseluruhan mengisi penuh lebar kolom Total. */
#purchaseTable .discount-group { width: 100%; }

/* Addon dibuat rapat supaya select di dalamnya yang menentukan lebar,
   bukan padding bawaan Bootstrap. */
#purchaseTable .discount-type-addon {
    padding: 0;
    width: 1%;
    white-space: nowrap;
}

/* Dropdown satuan diskon (% atau nominal). Lebar dipatok supaya kedua
   pilihan terbaca penuh dan tidak terpotong. */
#purchaseTable .discount-type-addon select {
    width: 68px;
    height: 32px;
    border: 0;
    background: transparent;
    padding: 0 4px;
    outline: none;
}
</style>


<!-- Add New Purchase Start -->
<div class="content-wrapper">
    <section class="content-header">
        <div class="header-icon">
            <i class="pe-7s-note2"></i>
        </div>
        <div class="header-title">
            <h1><?php echo display('purchase') ?></h1>
            <small><?php echo display('purchase_edit') ?></small>
            <ol class="breadcrumb">
                <li><a href="#"><i class="pe-7s-home"></i> <?php echo display('home') ?></a></li>
                <li><a href="#"><?php echo display('purchase') ?></a></li>
                <li class="active"><?php echo display('purchase_edit') ?></li>
            </ol>
        </div>
    </section>

    <section class="content">
        <!-- Alert Message -->
        <?php
            $message = $this->session->userdata('message');
            if (isset($message)) {
        ?>
        <div class="alert alert-info alert-dismissable">
            <button type="button" class="close" data-dismiss="alert" aria-hidden="true"></button>
            <?php echo $message ?>
        </div>
        <?php
         $this->session->unset_userdata('message');
         }
         $error_message = $this->session->userdata('error_message');
        if (isset($error_message)) {
        ?>
        <div class="alert alert-danger alert-dismissable">
            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
            <?php echo $error_message ?>
        </div>
        <?php
           $this->session->unset_userdata('error_message');
        }
        ?>

        <?php
        if($this->permission1->method('manage_purchase','update')->access()){ ?>
        <!-- Purchase report -->
        <div class="row">
            <div class="col-sm-12">
                <div class="panel panel-bd lobidrag">
                    <div class="panel-heading">
                        <div class="panel-title">
                            <h4><?php echo display('purchase_edit') ?></h4>
                        </div>
                    </div>

                    <div class="panel-body">
                      <?php echo form_open_multipart('Cpurchase/purchase_update',array('class' => 'form-vertical', 'id' => 'purchase_update'))?>
                        <div class="row">
                            <div class="col-sm-6">
                               <div class="form-group row">
                                    <label for="manufacturer_sss" class="col-sm-3 col-form-label"><?php echo display('manufacturer') ?>
                                        <i class="text-danger">*</i>
                                    </label>
                                   <div class="col-sm-9">
                                        <select name="manufacturer_id" id="manufacturer_id" class="form-control " required="" tabindex="1">

                                            {manufacturer_list}
                                            <option value="{manufacturer_id}">{manufacturer_name}</option>
                                            {/manufacturer_list}
                                            {manufacturer_selected}
                                            <option value="{manufacturer_id}" selected="">{manufacturer_name}</option>
                                            {/manufacturer_selected}
                                        </select>
                                    </div>


                                </div>
                            </div>

                             <div class="col-sm-6">
                                <div class="form-group row">
                                    <label for="date" class="col-sm-4 col-form-label"><?php echo display('purchase_date') ?>
                                        <i class="text-danger">*</i>
                                    </label>
                                    <div class="col-sm-8">
                                        <input type="text" tabindex="2" class="form-control datepicker" name="purchase_date" value="{purchase_date}" id="date" required />
                                          <input type="hidden" name="purchase_id" value="{purchase_id}">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group row">
                                    <label for="invoice_no" class="col-sm-3 col-form-label"><?php echo display('invoice_no') ?>
                                        <i class="text-danger">*</i>
                                    </label>
                                    <div class="col-sm-9">
                                        <input type="text" tabindex="3" class="form-control" name="chalan_no" placeholder="<?php echo display('invoice_no') ?>" id="invoice_no" required  value="{chalan_no}" />
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-6">
                               <div class="form-group row">
                                    <label for="adress" class="col-sm-4 col-form-label"><?php echo display('details') ?>
                                    </label>
                                    <div class="col-sm-8">
                                         <textarea class="form-control" tabindex="4" id="adress" name="purchase_details" placeholder=" <?php echo display('details') ?>" rows="1">{purchase_details}</textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                           <div class="row">
                              <div class="col-sm-6" id="payment_from_1">
                                <div class="form-group row">
                                    <label for="payment_type" class="col-sm-3 col-form-label"><?php
                                        echo display('payment_type');
                                        ?> <i class="text-danger">*</i></label>
                                    <div class="col-sm-9">
                                        <select name="paytype" class="form-control" required="" onchange="bank_paymet(this.value)" tabindex="5">
                                            <option value="">Select Payment Option</option>
                                            <option value="1" <?php if($paytype ==1){echo 'selected';}?>>Cash Payment</option>
                                            <option value="2" <?php if($paytype ==2){echo 'selected';}?>>Bank Payment</option>
                                            <option value="3" <?php if($paytype ==3){echo 'selected';}?>>Due Payment</option> 
                                        </select>
                                       <input type="hidden" name="" id="paytype" value="{paytype}"> 

                                     
                                    </div>
                                 
                                </div>
                            </div>
                             <div class="col-sm-6" id="bank_div">
                            <div class="form-group row">
                                <label for="bank" class="col-sm-4 col-form-label"><?php
                                    echo display('bank');
                                    ?> <i class="text-danger">*</i></label>
                                <div class="col-sm-8">
                                   <select name="bank_id" class="form-control"  id="bank_id">
                                        <option value="">Select Location</option>
                                        <?php foreach($bank_list as $bank){?>
                                            <option value="<?php echo html_escape($bank['bank_id'])?>" <?php if($bank['bank_id'] == $bank_id){echo 'selected';}?>><?php echo html_escape($bank['bank_name']);?></option>
                                        <?php }?>
                                    </select>
                                 
                                </div>
                             
                            </div>
                        </div>
                        </div>

                        <div class="table-responsive">
                            <table class="table table-bordered table-hover purchase-table" id="purchaseTable">
                                <thead>
                                    <tr>
                                            <th class="text-center" width="20%"><?php echo display('item_information') ?><i class="text-danger">*</i></th>
                                            <th class="text-center"><?php echo display('batch_id') ?> <i class="text-danger">*</i></th>
                                             <th class="text-center"><?php echo display('expeire_date') ?> <i class="text-danger">*</i></th>
                                            <th class="text-center"><?php echo display('stock_ctn') ?></th>
                                            <th class="text-center"><?php echo display('quantity') ?> <i class="text-danger">*</i></th>
                                            <th class="text-center"><?php echo display('manufacturer_rate') ?><i class="text-danger">*</i></th>

                                            <th class="text-center"><?php echo display('discount') ?> (%)</th>

                                            <!-- Dilebarkan: menampung input diskon keseluruhan
                                                 beserta dropdown %/nominal di bagian footer. -->
                                            <th class="text-center col-total"><?php echo display('total') ?></th>

                                            <th class="text-center"><?php echo display('action') ?></th>
                                        </tr>
                                </thead>
                                <tbody id="addPurchaseItem">
                                     {purchase_info}
                                    <tr>
                                        <td class="span3 manufacturer">
                                           <input type="text" name="product_name" required class="form-control product_name productSelection" onkeypress="product_pur_or_list({sl});" placeholder="<?php echo display('product_name') ?>" id="product_name_{sl}" tabindex="{medtap}" value="{product_name}"  >

                                            <input type="hidden" class="autocomplete_hidden_value product_id_{sl}" name="product_id[]" id="SchoolHiddenId" value="{product_id}"/>

                                            <input type="hidden" class="sl" value="{sl}">
                                        </td>
                                         <td>
                                                <input type="text" name="batch_id[]" id="batch_id_{sl}" class="form-control text-right"  tabindex="{battap}" placeholder="<?php echo display('batch_id') ?>" required="required" value="{batch_id}"/>
                                            </td>
                                            <td>
                                                <input type="text" name="expeire_date[]" id="expeire_date_{sl}" class="form-control datepicker"   tabindex="{expttap}" placeholder="<?php echo display('expeire_date') ?>" value="{expeire_date}" required="required" onchange="checkExpiredate({sl})"/>
                                            </td>

                                       <td class="wt">
                                                <input type="text" id="available_quantity_{sl}" class="form-control text-right stock_ctn_{sl}" placeholder="0.00" readonly/>
                                            </td>

                                            <td class="text-right">

                                                <input type="text" name="product_quantity[]" id="quantity_{sl}" required="required" class="form-control text-right store_cal_{sl}" onkeyup="calculate_store({sl}),checkqty({sl});" onchange="calculate_store({sl});" placeholder="0.00" value="{quantity}" min="0" tabindex="{qtytap}"/>
                                            </td>
                                            <td class="test">
                                                <input type="text" name="product_rate[]" onkeyup="calculate_store({sl}),checkqty({sl});" onchange="calculate_store({sl});" id="product_rate_{sl}" class="form-control product_rate_{sl} text-right" placeholder="0.00" value="{rate}" required="required" min="0" tabindex="{ratetap}"/>
                                            </td>

                                            <td class="text-right">
                                                <input type="text" name="discount[]" onkeyup="calculate_store({sl});" onchange="calculate_store({sl});" id="discount_{sl}" class="form-control discount_{sl} text-right" placeholder="0.00" value="{discount}" min="0" max="100" tabindex="{disctap}"/>
                                            </td>

                                            <td class="text-right">
                                                <input class="form-control total_price text-right" type="text" name="total_price[]" id="total_price_{sl}" value="{total_amount}" readonly="readonly" />
                                                <input type="hidden" class="discount_amount" id="discount_amount_{sl}" value="0"/>
                                            </td>
                                            <td>



                                                 <button type="button" class="btn btn-danger" tabindex="{deletetap}" onclick="deleteRow(this)"><i class="fa fa-close"></i></button>
                                            </td>
                                    </tr>
                                    {/purchase_info}
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="2">
                                          

                                            <input type="hidden" name="baseUrl" class="baseUrl" value="<?php echo base_url();?>"/>
                                            <input type="hidden" name="total_discount" id="total_discount" value="0.00"/>
                                            <!-- Nilai rupiah diskon keseluruhan, dihitung di JS -->
                                            <input type="hidden" name="overall_discount_amount" id="overall_discount_amount" value="0.00"/>
                                            <!-- Nilai rupiah PPN, dihitung di JS -->
                                            <input type="hidden" name="ppn_amount" id="ppn_amount" value="0.00"/>
                                        </td>
                                        <td class="text-right" colspan="5"><b><?php echo display('sub_total') ?>:</b></td>
                                        <td class="text-right">
                                            <input type="text" id="subTotal" class="text-right form-control" value="0.00" readonly="readonly" />
                                        </td>
                                        <td> <button id="add_invoice_item" tabindex="{addtaps}" type="button" class="btn btn-info" name="add-invoice-item" onClick="addPurchaseOrderField1('addPurchaseItem')" ><i class="fa fa-plus"></i></button></td>
                                    </tr>
                                    <!-- Diskon keseluruhan: persen (10) atau nominal (100000) -->
                                    <tr>
                                        <td colspan="2"></td>
                                        <td class="text-right" colspan="5"><b><?php echo display('overall_discount') ?>:</b></td>
                                        <td class="text-right">
                                            <div class="input-group discount-group">
                                                <input type="text" name="overall_discount_input" id="overall_discount_input"
                                                       class="form-control text-right" placeholder="0" value="{overall_discount_input}"
                                                       onkeyup="calculate_overall_discount();" onchange="calculate_overall_discount();"/>
                                                <!-- input-group-addon, bukan input-group-btn: di Bootstrap 3
                                                     input-group-btn dirancang untuk tombol dan membuat select
                                                     menciut sehingga pilihannya tidak terbaca. -->
                                                <span class="input-group-addon discount-type-addon">
                                                    <select name="overall_discount_type" id="overall_discount_type"
                                                            onchange="calculate_overall_discount();">
                                                        <option value="percent" {selected_percent}>%</option>
                                                        <!-- Label ditulis langsung, bukan display('amount'),
                                                             karena frasa 'amount' dipakai di banyak halaman lain. -->
                                                        <option value="fixed" {selected_fixed}>Rp.</option>
                                                    </select>
                                                </span>
                                            </div>
                                            <small class="text-muted" id="overall_discount_info"></small>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <!-- PPN: dihitung dari nilai sesudah diskon, lalu ditambahkan -->
                                    <tr>
                                        <td colspan="2"></td>
                                        <td class="text-right" colspan="5"><b><?php echo display('ppn') ?>:</b></td>
                                        <td class="text-right">
                                            <div class="input-group discount-group">
                                                <input type="text" name="ppn_input" id="ppn_input"
                                                       class="form-control text-right" placeholder="0" value="{ppn_input}"
                                                       onkeyup="calculate_overall_discount();" onchange="calculate_overall_discount();"/>
                                                <span class="input-group-addon discount-type-addon">
                                                    <select name="ppn_type" id="ppn_type"
                                                            onchange="calculate_overall_discount();">
                                                        <option value="percent" {ppn_selected_percent}>%</option>
                                                        <option value="fixed" {ppn_selected_fixed}>Rp.</option>
                                                    </select>
                                                </span>
                                            </div>
                                            <small class="text-muted" id="ppn_info"></small>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"></td>
                                        <td class="text-right" colspan="5"><b><?php echo display('grand_total') ?>:</b></td>
                                        <td class="text-right">
                                            <input type="text" id="grandTotal" class="text-right form-control" name="grand_total_price" value="{grand_total}" readonly="readonly" />
                                        </td>
                                        <td></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>

                        <div class="form-group row">
                            <div class="col-sm-6">
                                <input type="submit" id="add_purchase" class="btn btn-primary btn-large" name="add-purchase" value="<?php echo display('save_changes') ?>" />

                            </div>
                        </div>
                    <?php echo form_close()?>
                    </div>
                </div>
            </div>
        </div>
         <?php
        }
        else{
            ?>
            <div class="row">
                <div class="col-sm-12">
                    <div class="panel panel-bd lobidrag">
                        <div class="panel-heading">
                            <div class="panel-title">
                                <h4><?php echo display('You do not have permission to access. Please contact with administrator.');?></h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <?php
        }
        ?>
    </section>
</div>
