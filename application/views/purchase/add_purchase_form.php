
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

/* Panduan pengisian CSV di dalam modal unggah.
   Tema menimpa .alert-info menjadi teks putih, jadi panduan ini memakai
   kelas sendiri dengan warna teks gelap yang dipatok eksplisit. */
.csv-help {
    color: #374767;
    background-color: #f7fbfd;
    border: 1px solid #bce8f1;
    border-radius: 4px;
    padding: 15px;
    margin-bottom: 15px;
}

/* Semua turunan ikut gelap, termasuk isi tabel keterangan kolom. */
.csv-help p,
.csv-help small,
.csv-help strong,
.csv-help em,
.csv-help td,
.csv-help th {
    color: #374767;
}

.csv-help .table {
    background-color: #fff;
    margin-bottom: 10px;
}

/* Baris chalan_no disorot karena paling sering salah isi. Warna latar
   dipatok agar tidak tertimpa gaya .warning bawaan tema. */
.csv-help .table > tbody > tr.warning > td {
    background-color: #fcf8e3;
}

/* Label "Upload CSV File" di modal. Tema membuat .col-form-label berwarna
   merah (gaya pesan galat), padahal ini label biasa. Dikembalikan ke warna
   teks normal; tanda bintang wajib tetap merah lewat .text-danger. */
#purchase_csv_modal .col-form-label {
    color: #374767;
}
</style>


<!-- Add New Purchase Start -->
<div class="content-wrapper">
    <section class="content-header">
        <div class="header-icon">
            <i class="pe-7s-note2"></i>
        </div>
        <div class="header-title">
            <h1><?php echo display('add_purchase') ?></h1>
            <small><?php echo display('add_new_purchase') ?></small>
            <ol class="breadcrumb">
                <li><a href="#"><i class="pe-7s-home"></i> <?php echo display('home') ?></a></li>
                <li><a href="#"><?php echo display('purchase') ?></a></li>
                <li class="active"><?php echo display('add_purchase') ?></li>
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
        if($this->permission1->method('add_purchase','create')->access()){ ?>
        <!-- Purchase report -->
        <div class="row">
            <div class="col-sm-12">
                <div class="panel panel-bd lobidrag">
                    <div class="panel-heading">
                        <div class="panel-title">
                            <h4>
                                <?php echo display('add_purchase') ?>
                                <!-- Pembuka modal unggah CSV. Modalnya sudah ada di
                                     bawah halaman ini (#purchase_csv_modal). -->
                                <a href="#" class="btn btn-success pull-right" data-toggle="modal" data-target="#purchase_csv_modal">
                                    <i class="fa fa-upload"></i> Upload Pembelian CSV
                                </a>
                            </h4>
                        </div>
                    </div>

                    <div class="panel-body">
                    <?php echo form_open_multipart('Cpurchase/insert_purchase',array('class' => 'form-vertical', 'id' => 'validate','name' => 'insert_purchase'))?>
                        

                        <div class="row" id="manufacturer_info">
                            <div class="col-sm-6">
                               <div class="form-group row">
                                    <label for="manufacturer_sss" class="col-sm-3 col-form-label"><?php echo display('manufacturer')?>
                                        <i class="text-danger">*</i>
                                    </label>
                                    <div class="col-sm-9">
                                        <select name="manufacturer_id" id="manufacturer_id" class="form-control " required="required" tabindex="1" onchange="product_pur_or_list()"> 
                                          

                                            <option value=""> <?php echo display('select_manufacturer')?></option>
                                            <?php 
                                            $manufacturer_id = $this->session->userdata('manufacturer_id');
                                            if ($all_manufacturer){ 
                                                foreach ($all_manufacturer as $manufac) {
                                            ?>
                                            <option value="<?php echo html_escape($manufac['manufacturer_id'])?>" <?php if ($manufacturer_id == $manufac['manufacturer_id']){echo "selected";} ?>><?php echo html_escape($manufac['manufacturer_name'])?></option>
                                            <?php
                                                }
                                            }
                                            ?>
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
                                        <?php $date = date('Y-m-d'); ?>
                                        <input type="text" tabindex="2" class="form-control datepicker" name="purchase_date" value="<?php echo $date; ?>" id="purdate" required />
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
                                        <input type="text" tabindex="3" class="form-control" name="chalan_no" placeholder="<?php echo display('invoice_no') ?>" id="invoice_no" required />
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-6">
                               <div class="form-group row">
                                    <label for="adress" class="col-sm-4 col-form-label"><?php echo display('details') ?>
                                    </label>
                                    <div class="col-sm-8">
                                        <textarea class="form-control" tabindex="4" id="adress" name="purchase_details" placeholder=" <?php echo display('details') ?>" rows="1"></textarea>
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
                                        <select name="paytype" class="form-control" id="paytype" required="" onchange="bank_paymet(this.value)" tabindex="5">
                                            <option value="1">Cash Payment</option>
                                            <option value="2">Bank Payment</option>
                                            <option value="3">Due Payment</option>
                                        </select>



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
                                            <option value="<?php echo html_escape($bank['bank_id'])?>"><?php echo html_escape($bank['bank_name']);?></option>
                                        <?php }?>
                                    </select>

                                </div>

                            </div>
                        </div>
                        </div>

                        <!-- Tanggal jatuh tempo. Hanya tampil (dan wajib diisi)
                             bila jenis pembayaran "Due Payment"; diatur oleh
                             due_date_toggle() di purchase.js. -->
                        <div class="row">
                            <div class="col-sm-6" id="due_date_div" style="display:none;">
                                <div class="form-group row">
                                    <label for="due_date" class="col-sm-3 col-form-label"><?php
                                        echo display('due_date');
                                        ?> <i class="text-danger">*</i></label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control datepicker" name="due_date" id="due_date" placeholder="<?php echo display('due_date') ?>" tabindex="6" autocomplete="off" />
                                        <span class="help-block small">Tanggal pembayaran ke distributor harus dilunasi.</span>
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
                                            <!-- Dilebarkan: kolom ini menampung input diskon keseluruhan
                                                 beserta dropdown %/nominal di bagian footer. -->
                                            <th class="text-center col-total"><?php echo display('total') ?></th>
                                            <th class="text-center"><?php echo display('action') ?></th>
                                        </tr>
                                </thead>
                                <tbody id="addPurchaseItem">
                                    <tr>
                                        <td class="span3 manufacturer">
                                           <input type="text" name="product_name" required class="form-control product_name productSelection" onkeypress="product_pur_or_list(1);" placeholder="<?php echo display('product_name') ?>" id="product_name_1" tabindex="6" >

                                            <input type="hidden" class="autocomplete_hidden_value product_id_1" name="product_id[]" id="SchoolHiddenId"/>

                                            <input type="hidden" class="sl" value="1">
                                        </td>
                                         <td>
                                                <input type="text" name="batch_id[]" id="batch_id_1" class="form-control text-right"  tabindex="7" placeholder="<?php echo display('batch_id') ?>" required=""/>
                                            </td>
                                            <td>
                                                <input type="text" name="expeire_date[]" id="expeire_date_1" class="form-control datepicker " tabindex="8"    placeholder="<?php echo display('expeire_date') ?>" onchange="checkExpiredate(1)" required=""/>
                                            </td>

                                       <td class="wt">
                                                <input type="text" id="available_quantity_1" class="form-control text-right stock_ctn_1" placeholder="0.00" readonly/>
                                            </td>
                                        
                                            <td class="text-right">
                                                <input type="text" name="product_quantity[]" id="quantity_1" class="form-control text-right store_cal_1" onkeyup="calculate_store(1),checkqty(1);" onchange="calculate_store(1);" placeholder="0.00" value="" min="0" tabindex="9" required="required"/>
                                            </td>
                                            <td class="test">
                                                <input type="text" name="product_rate[]" onkeyup="calculate_store(1),checkqty(1);" onchange="calculate_store(1);" id="product_rate_1" class="form-control product_rate_1 text-right" placeholder="0.00" value="" min="0" tabindex="10" required="required" />
                                            </td>

                                            <td class="text-right">
                                                <input type="text" name="discount[]" onkeyup="calculate_store(1);" onchange="calculate_store(1);" id="discount_1" class="form-control discount_1 text-right" placeholder="0.00" value="0" min="0" max="100" tabindex="11"/>
                                            </td>

                                            <td class="text-right">
                                                <input class="form-control total_price text-right" type="text" name="total_price[]" id="total_price_1" value="0.00" readonly="readonly" />
                                                <input type="hidden" class="discount_amount" id="discount_amount_1" value="0"/>
                                            </td>
                                            <td>

                                               
                                            <button type="button" class="btn btn-danger" tabindex="12" onclick="deleteRow(this)"><i class="fa fa-close"></i></button>
                                                
                                            </td>
                                    </tr>
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
                                        <td>
                                        <button id="add_invoice_item" type="button" class="btn btn-info" name="add-invoice-item" onClick="addPurchaseOrderField1('addPurchaseItem')" tabindex="13"><i class="fa fa-plus"></i></button>
                                        </td>
                                    </tr>
                                    <!-- Diskon keseluruhan: bisa persen (10) atau nominal (100000) -->
                                    <tr>
                                        <td colspan="2"></td>
                                        <td class="text-right" colspan="5"><b><?php echo display('overall_discount') ?>:</b></td>
                                        <td class="text-right">
                                            <div class="input-group discount-group">
                                                <input type="text" name="overall_discount_input" id="overall_discount_input"
                                                       class="form-control text-right" placeholder="0" value="0"
                                                       onkeyup="calculate_overall_discount();" onchange="calculate_overall_discount();"
                                                       tabindex="14"/>
                                                <!-- input-group-addon, bukan input-group-btn: di Bootstrap 3
                                                     input-group-btn dirancang untuk tombol dan membuat select
                                                     menciut sehingga pilihannya tidak terbaca. -->
                                                <span class="input-group-addon discount-type-addon">
                                                    <select name="overall_discount_type" id="overall_discount_type"
                                                            onchange="calculate_overall_discount();" tabindex="15">
                                                        <option value="percent">%</option>
                                                        <!-- Label ditulis langsung, bukan display('amount'),
                                                             karena frasa 'amount' dipakai di banyak halaman lain. -->
                                                        <option value="fixed">Rp.</option>
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
                                                       class="form-control text-right" placeholder="0" value="0"
                                                       onkeyup="calculate_overall_discount();" onchange="calculate_overall_discount();"
                                                       tabindex="16"/>
                                                <span class="input-group-addon discount-type-addon">
                                                    <select name="ppn_type" id="ppn_type"
                                                            onchange="calculate_overall_discount();" tabindex="17">
                                                        <option value="percent">%</option>
                                                        <option value="fixed">Rp.</option>
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
                                            <input type="text" id="grandTotal" class="text-right form-control" name="grand_total_price" value="0.00" readonly="readonly" />
                                        </td>
                                        <td></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>

                        <div class="form-group row">
                            <div class="col-sm-6">
                                <input type="submit" id="add_purchase" class="btn btn-primary btn-large" name="add-purchase" value="<?php echo display('submit') ?>" />
                              
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
        <div id="purchase_csv_modal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Upload Csv Purchase</h4>
      </div>
      <div class="modal-body">

                <div class="panel panel-bd">
                    <div class="panel-heading">
                        <div class="panel-title">
                            <h4><?php echo 'CSV Purchase'; ?><a href="<?php echo base_url('Cpurchase/download_csv_template_purchase') ?>" class="btn btn-primary pull-right"><i class="fa fa-download"></i> Download Template CSV</a></h4>
                        </div>
                    </div>

                    <div class="panel-body">
                     <div class="col-sm-12">
                        <!-- Panduan ini sengaja tidak memakai .alert-info: tema
                             menimpanya menjadi teks putih (color:#fff), sehingga
                             tulisan tidak terbaca di atas latar terang. Warna
                             teks dipatok gelap di sini. -->
                        <div class="csv-help">
                            <p><strong>Cara pakai:</strong> satu baris CSV = satu barang.
                            Baris dengan <code>chalan_no</code> dan distributor yang sama
                            akan digabung menjadi satu pembelian.</p>

                            <p><strong>Keterangan kolom</strong> (urutannya harus sesuai tabel ini):</p>
                            <div class="table-responsive">
                            <table class="table table-bordered table-condensed">
                                <thead>
                                    <tr>
                                        <th style="width:160px">Kolom</th>
                                        <th style="width:70px" class="text-center">Wajib</th>
                                        <th>Keterangan</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><code>manufacturer_name</code></td>
                                        <td class="text-center">Ya</td>
                                        <td>Nama distributor. Harus sudah terdaftar dan ditulis persis sama.</td>
                                    </tr>
                                    <tr>
                                        <td><code>purchase_date</code></td>
                                        <td class="text-center">Ya</td>
                                        <td>Tanggal pembelian, format <code>YYYY-MM-DD</code>. Contoh: <code>2026-08-07</code>.</td>
                                    </tr>
                                    <tr class="warning">
                                        <td><code>chalan_no</code></td>
                                        <td class="text-center">Ya</td>
                                        <td>
                                            <strong>Nomor faktur dari distributor</strong> &mdash; nomor yang
                                            tertera pada faktur/surat jalan fisik yang Anda terima.
                                            Contoh: <code>INV/KF/2026/00123</code>.
                                            <br>
                                            <small>
                                            Ini kolom yang sama dengan isian <em>Nomor Faktur</em> pada
                                            form pembelian manual. Nomor <strong>tidak boleh sama</strong>
                                            dengan pembelian sebelumnya dari distributor yang sama, jadi
                                            <strong>tidak bisa diisi nilai tetap</strong>. Distributor yang
                                            berbeda boleh memakai nomor yang sama.
                                            <br>
                                            Barang-barang dengan nomor faktur dan distributor yang sama
                                            akan digabung menjadi satu pembelian. Bila distributor tidak
                                            memberi nomor, pakai pola sendiri yang unik,
                                            misalnya <code>KF-20260807-01</code>.
                                            </small>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><code>details</code></td>
                                        <td class="text-center">Tidak</td>
                                        <td>Keterangan pembelian. Boleh dikosongkan.</td>
                                    </tr>
                                    <tr>
                                        <td><code>product_name</code></td>
                                        <td class="text-center">Ya</td>
                                        <td>Nama barang. Harus sudah terdaftar dan ditulis persis sama.</td>
                                    </tr>
                                    <tr>
                                        <td><code>batch_id</code></td>
                                        <td class="text-center">Ya</td>
                                        <td>Nomor batch barang. Contoh: <code>BATCH-001</code>.</td>
                                    </tr>
                                    <tr>
                                        <td><code>expiry_date</code></td>
                                        <td class="text-center">Ya</td>
                                        <td>Tanggal kedaluwarsa, format <code>YYYY-MM-DD</code>.</td>
                                    </tr>
                                    <tr>
                                        <td><code>qty</code></td>
                                        <td class="text-center">Ya</td>
                                        <td>Jumlah barang. Angka lebih dari 0.</td>
                                    </tr>
                                    <tr>
                                        <td><code>price</code></td>
                                        <td class="text-center">Ya</td>
                                        <td>Harga beli per satuan. Angka tanpa titik/koma pemisah ribuan.</td>
                                    </tr>
                                    <tr>
                                        <td><code>discount</code></td>
                                        <td class="text-center">Tidak</td>
                                        <td>Diskon per barang dalam <strong>persen</strong>. Kosong dianggap <code>0</code>.</td>
                                    </tr>
                                    <tr>
                                        <td><code>payment_type</code></td>
                                        <td class="text-center">Tidak</td>
                                        <td>Jenis pembayaran: <code>1</code> = Tunai, <code>2</code> = Transfer. Kosong dianggap <code>1</code>.</td>
                                    </tr>
                                    <tr class="info">
                                        <td colspan="3">
                                            <strong>Diskon keseluruhan &amp; PPN</strong> &mdash; sama dengan isian
                                            di bagian bawah form pembelian manual. Berlaku untuk
                                            <strong>satu pembelian</strong> (bukan per barang), jadi
                                            <strong>cukup diisi di baris pertama</strong> tiap nomor faktur;
                                            baris berikutnya boleh dikosongkan.
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><code>overall_discount_input</code></td>
                                        <td class="text-center">Tidak</td>
                                        <td>Besar diskon keseluruhan. Kosong dianggap <code>0</code>.</td>
                                    </tr>
                                    <tr>
                                        <td><code>overall_discount_type</code></td>
                                        <td class="text-center">Tidak</td>
                                        <td>
                                            <code>percent</code> &rarr; dihitung sebagai <strong>persen</strong> dari subtotal.
                                            <code>fixed</code> &rarr; dianggap <strong>rupiah</strong> langsung.
                                            Kosong dianggap <code>percent</code>.
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><code>ppn_input</code></td>
                                        <td class="text-center">Tidak</td>
                                        <td>Besar PPN. Kosong dianggap <code>0</code>. Contoh: <code>11</code> untuk PPN 11%.</td>
                                    </tr>
                                    <tr>
                                        <td><code>ppn_type</code></td>
                                        <td class="text-center">Tidak</td>
                                        <td>
                                            <code>percent</code> &rarr; persen dari nilai <strong>sesudah diskon</strong>.
                                            <code>fixed</code> &rarr; rupiah langsung.
                                            Kosong dianggap <code>percent</code>.
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            </div>

                            <p><strong>Urutan perhitungan</strong> (sama persis dengan input manual):</p>
                            <div class="table-responsive">
                            <table class="table table-bordered table-condensed">
                                <tbody>
                                    <tr>
                                        <td>Subtotal</td>
                                        <td>jumlah semua <code>qty &times; price</code> setelah diskon per barang</td>
                                        <td class="text-right"><code>1.000.000</code></td>
                                    </tr>
                                    <tr>
                                        <td>Diskon keseluruhan</td>
                                        <td><code>overall_discount_input</code> <code>5</code> tipe <code>percent</code></td>
                                        <td class="text-right"><code>&minus; 50.000</code></td>
                                    </tr>
                                    <tr>
                                        <td>Nilai bersih</td>
                                        <td>dasar perhitungan PPN</td>
                                        <td class="text-right"><code>950.000</code></td>
                                    </tr>
                                    <tr>
                                        <td>PPN</td>
                                        <td><code>ppn_input</code> <code>11</code> tipe <code>percent</code>, dihitung dari nilai bersih</td>
                                        <td class="text-right"><code>+ 104.500</code></td>
                                    </tr>
                                    <tr class="success">
                                        <td><strong>Grand total</strong></td>
                                        <td>nilai bersih + PPN</td>
                                        <td class="text-right"><strong><code>1.054.500</code></strong></td>
                                    </tr>
                                </tbody>
                            </table>
                            </div>

                            <p class="m-b-0"><small>Bila ada satu baris yang salah, seluruh impor
                            dibatalkan dan tidak ada data yang tersimpan &mdash; jadi Anda bisa
                            memperbaiki file lalu mengunggah ulang dengan aman.</small></p>
                        </div>
                     </div>
                      <?php echo form_open_multipart('Cpurchase/uploadCsv_Purchase',array('class' => 'form-vertical', 'id' => 'csv_purchase_form','name' => 'insert_csv_purchase'))?>
                            <div class="col-sm-12">
                                <div class="form-group row">
                                    <label for="upload_csv_file" class="col-sm-4 col-form-label"><?php echo display('upload_csv_file') ?> <i class="text-danger">*</i></label>
                                    <div class="col-sm-8">
                                        <input class="form-control" name="upload_csv_file" type="file" id="upload_csv_file" placeholder="<?php echo display('upload_csv_file') ?>" required>
                                    </div>
                                </div>
                            </div>
                        
                       <div class="col-sm-12">
                        <div class="form-group row">
                            <div class="col-sm-12 text-right">
                                <input type="submit" id="add-product" class="btn btn-primary btn-large" name="add-product" value="<?php echo display('submit') ?>" />
                                  <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                               
                            </div>
                        </div>
                        </div>
                          <?php echo form_close()?>
                    </div>
                    </div>
                  
               
     
      </div>
     
    </div>

  </div>
</div>
    </section>
</div>



