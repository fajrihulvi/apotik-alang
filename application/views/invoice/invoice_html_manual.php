<?php
    $CI =& get_instance();
    $CI->load->model('Web_settings');
    $Web_settings = $CI->Web_settings->retrieve_setting_editdata();
?>
<script src="<?php echo base_url() ?>my-assets/js/admin_js/invoice_onloadprint.js" type="text/javascript"></script>
<style>
    @media print {
  #printPageButton {
    display: none;
  }
   #main-footer {
    display: none;
  }
  #content-header{
       display: none;
  }
  #pre-ldr{
    display: none;  
  }
  
  #main-heades{
      display:none;
  }
  /* Sidebar kiri tidak ikut tercetak */
  .main-sidebar, .left-side{
      display:none !important;
  }
  .content-wrapper{
      margin-left:0 !important;
  }

  /* ---- Layout struk thermal kasir (kertas 80mm) ---- */
  @page {
      size: 80mm auto;   /* tinggi menyesuaikan isi */
      margin: 0;
  }
  html, body{
      width: 80mm;
      margin: 0 !important;
      padding: 0 !important;
      background: #fff !important;
      font-size: 7.5px !important;
      color: #000 !important;
  }
  /* Samakan seluruh teks di area cetak, termasuk elemen yang
     punya ukuran font bawaan sendiri (h1-h6, strong, address, dll). */
  #printableArea, #printableArea *{
      font-size: 7.5px !important;
      line-height: 1.25 !important;
  }
  /* Hilangkan panel/box agar tidak makan lebar kertas */
  .content-wrapper, .content, .container, .container-fluid,
  .row, .col-sm-12, .panel, .panel-bd, .panel-body{
      width: 100% !important;
      max-width: 80mm !important;
      margin: 0 !important;
      padding: 0 !important;
      float: none !important;
      border: none !important;
      box-shadow: none !important;
      background: #fff !important;
  }
  #printableArea{
      width: 80mm !important;
      padding: 2mm !important;
      box-sizing: border-box;
  }
  /* Tabel barang dibuat rapat & tanpa garis kotak */
  #printableArea table{
      width: 100% !important;
      border-collapse: collapse !important;
      font-size: 7.5px !important;
      table-layout: fixed;
  }
  #printableArea table th,
  #printableArea table td{
      border: none !important;
      padding: 1px 2px !important;
      word-wrap: break-word;
      vertical-align: top;
  }
  /* Garis pemisah tipis khas struk */
  #printableArea thead th{
      border-bottom: 1px dashed #000 !important;
      font-weight: bold;
  }
  #printableArea tfoot td, #printableArea tfoot th{
      border-top: 1px dashed #000 !important;
  }
  #printableArea .table-striped > tbody > tr:nth-of-type(odd){
      background: #fff !important;
  }
  /* Bagi lebar kolom: nama obat paling lebar, angka rata kanan */
  #printableArea table th:first-child,
  #printableArea table td:first-child{ width: 7mm !important; }
  #printableArea table th:nth-child(2),
  #printableArea table td:nth-child(2){ width: auto !important; text-align: left !important; }
  #printableArea table th:nth-child(n+3),
  #printableArea table td:nth-child(n+3){ width: 15mm !important; text-align: right !important; }

  /* ---- Blok total (Sebelumnya / Jumlah Total / Dibayarkan) ----
     Di kertas 80mm kolom col-xs-4 terlalu sempit sehingga tulisan
     terpotong per huruf. Dibuat melebar penuh & digeser ke kiri. */
  #printableArea .col-xs-4,
  #printableArea .col-xs-8{
      width: 100% !important;
      max-width: 100% !important;
      float: none !important;
      padding: 0 !important;
      margin: 0 !important;
  }
  /* Tabel total: label kiri, angka kanan, font lebih kecil */
  #printableArea .col-xs-4 table{
      width: 100% !important;
      table-layout: auto !important;
      font-size: 7.5px !important;
      margin: 0 !important;
  }
  #printableArea .col-xs-4 table th{
      width: auto !important;
      text-align: left !important;
      white-space: nowrap !important;   /* jangan pecah per huruf */
      font-size: 7.5px !important;
      padding: 0 2px 0 0 !important;
  }
  #printableArea .col-xs-4 table td{
      width: auto !important;
      text-align: right !important;
      white-space: nowrap !important;
      font-size: 7.5px !important;
      padding: 0 !important;
  }
  #printableArea .grand_total{ font-size: 7.5px !important; }
  /* Header & footer struk rata tengah */
  .receipt-header, .receipt-footer{
      padding: 1mm 0 !important;
      font-size: 7.5px !important;
  }
  .receipt-header img{ max-width: 60mm !important; }
  /* Jangan potong baris di tengah */
  tr, td, th{ page-break-inside: avoid !important; }
}
</style>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header" id="content-header">
        <div class="header-icon">
            <i class="pe-7s-note2"></i>
        </div>
        <div class="header-title">
            <h1><?php echo display('invoice_details') ?></h1>
            <small><?php echo display('invoice_details') ?></small>
            <ol class="breadcrumb">
                <li><a href="#"><i class="pe-7s-home"></i> <?php echo display('home') ?></a></li>
                <li><a href="#"><?php echo display('invoice') ?></a></li>
                <li class="active"><?php echo display('invoice_details') ?></li>
            </ol>
        </div>
    </section>
    <!-- Main content -->
    <section class="content">
    	<!-- Alert Message -->
	    <?php
	        $message = $this->session->userdata('message');
	        if (isset($message)) {
	    ?>
	    <div class="alert alert-info alert-dismissable">
	        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
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
        if($this->permission1->method('manage_invoice','read')->access() ){ ?>
        <div class="row">
            <div class="col-sm-12">
                <div class="panel panel-bd">
	                <div>
	                    <div class="panel-body" id="printableArea">
	                        <?php if (!empty($Web_settings[0]['receipt_header'])) { ?>
	                            <div class="receipt-header" style="text-align:center; padding:10px;"><?php echo $Web_settings[0]['receipt_header']; ?></div>
	                        <?php } ?>
	                        <div class="row print_header">
                                <div class="col-sm-8 company-content">
                                    <address class="margin-top10">
                                         <abbr>{tax_regno}</abbr>
                                    </address>

                                </div>
                                
                                 
                            </div>


	                        <div class="table-responsive m-b-20">
	                            <table class="table table-striped table-bordered">
	                                <thead>
	                                    <tr>
	                                        <th class="text-center"><?php echo display('sl') ?></th>
	                                        <th class="text-center"><?php echo display('product_name') ?></th>
	                                        <th class="text-center"><?php echo display('quantity') ?></th>

	                                        <?php if ($discount_type == 1) { ?>
	                                        <th class="text-center"><?php echo display('discount_percentage') ?> %</th>
	                                        <?php }elseif($discount_type == 2){ ?>
	                                        <th class="text-center"><?php echo display('discount') ?> </th>
	                                        <?php }elseif($discount_type == 3) { ?>
	                                        <th class="text-center"><?php echo display('fixed_dis') ?> </th>
	                                        <?php } ?>

	                                        <th class="text-center"><?php echo display('rate') ?></th>
	                                        <th class="text-center"><?php echo display('ammount') ?></th>
	                                    </tr>
	                                </thead>
	                                <tbody>
										
										<?php 
                                        $subtotalamount = 0;
                                        $return_discount = 0;
                                        $return_amount = 0;
										 foreach($invoice_all_data as $details){?>
										<tr>
	                                    	<td class="text-center"><?php echo $details['sl']?></td>
	                                        <td class="text-center"><div><strong><?php echo medicine_name(html_escape($details['product_name']));
	                                        if($details['quantity'] < 0){
	                                        	echo '('.' <span class="text-danger">Returned</span> '.')';
	                                        }?></strong></div></td>
	                                        <td align="center"><?php
	                                        if($details['quantity'] < 0){ echo $qty = -1*html_escape($details['quantity']);}else{
	                                        	echo $qty = html_escape($details['quantity']);
	                                        }
	                                          ?></td>

	                                        <?php
	                                        if($details['quantity'] < 0){
	                                         $discounts =  -1*html_escape($details['discount']);
	                                         $tp = -1*html_escape($details['total_price']);
	                                        
	                                     }else{
	                                        $discounts = $details['discount'];
	                                        $tp = $details['total_price'];
	                                        }
	                                         if ($discount_type == 1) { ?>
	                                        <td align="center"><?php echo $discounts;
	                                         $dis_amount = ($qty*$details['rate']*$discounts)/100;
	                                        ?></td>
	                                        <?php }elseif($discount_type == 2){ ?>
	                                        <td align="center"><?php echo (($position==0)?"$currency ".$discounts."":"".$discounts." $currency");
                                            $dis_amount = $qty*$discounts;
	                                         ?></td>
	                                        <?php }else{ ?>
	                                        	 <td align="center"><?php echo (($position==0)?"$currency ".$discounts."":"".$discounts." $currency");
                                                 $dis_amount = $discounts;
	                                        	  ?></td>
	                                        <?php }?>

	                                        <td align="center"><?php echo (($position==0)?"$currency ".$details['rate']."":"".$details['rate']." $currency") ?></td>
	                                        <td align="right"><?php
	                                         if($details['quantity'] < 0){ 
	                                         	 $totalprice = $tp - $dis_amount;
	                                         	 $subtotalamount -= $totalprice;
	                                         	 $return_discount += $dis_amount;
	                                         	 $return_amount  +=$totalprice;
	                                         }else{
	                                        	 $totalprice = $tp;
	                                        	 $subtotalamount += $totalprice;
	                                        }

                                           
	                                         echo (($position==0)?"$currency ".html_escape($totalprice)."":"".html_escape($totalprice)." $currency") ?></td>
	                                    </tr>
	                                <?php }?>
	                                    
	                                </tbody>
	                                <tfoot>
	                                	<td align="center" colspan="1"><b><?php echo display('sub_total')?>:</b></td>
	                                	<td></td>
	                                	<td align="center" ><b>{subTotal_quantity}</b></td>
	                                	<td></td>
	                                	<td></td>

	                                	<td class="text-right" align="center" ><b><?php echo (($position==0)?"$currency ".html_escape($subtotalamount): html_escape($subtotalamount)." $currency") ?></b></td>
	                                </tfoot>
	                            </table>
	                        </div>
	                        <div class="row">

		                        	<div class="col-xs-8">

		                                <p></p>
		                                <p><strong>{invoice_details}</strong></p>
		                               
		                            </div>
		                            <div class="col-xs-4">

				                        <table class="table">
				                            <?php
                                        if ($invoice_all_data[0]['invoice_discount'] != 0) {
                                            ?>
                                            <tr>
                                                <th><?php echo display('invoice_discount') ?> : </th>
                                                <td class="text-right"><?php echo (($position == 0) ? "$currency {invoice_discount}" : "{invoice_discount} $currency") ?> </td>
                                            </tr>
                                            <?php
                                        }
                                        if ($invoice_all_data[0]['total_discount'] != 0) {
                                            ?>
                                            <tr>
                                                <th><?php echo display('total_discount') ?> : </th>
                                                <td class="text-right"><?php
                                                  $dis = number_format($raw_total_discount + $return_discount + $raw_invoice_discount, 2, '.', ',');
                                                 echo (($position == 0) ? "$currency ".html_escape($dis) : html_escape($dis)." $currency") ?> </td>
                                            </tr>
                                            <?php
                                        }
                                        if ($invoice_all_data[0]['total_tax'] != 0) {
                                            ?>
                                            <tr>
                                                <th class="text-left"><?php echo display('tax') ?> : </th>
                                                <td  class="text-right"><?php echo (($position == 0) ? "$currency {total_tax}" : "{total_tax} $currency") ?> </td>
                                            </tr>
                                        <?php } ?>
                                       
                                        <tr>
                                            <th class="text-left grand_total"><?php echo display('previous'); ?> :</th>
                                            <td class="text-right grand_total"><?php echo (($position == 0) ? "$currency {previous}" : "{previous} $currency") ?></td>
                                        </tr>
                                        <tr>
                                            <th class="text-left grand_total"><?php echo  display('grand_total') ?> :</th>
                                            <td class="text-right grand_total"><?php
                                            $tmnt = $raw_total_amount - $return_amount;
                                            $tmnt_show = number_format($tmnt, 2, '.', ',');
                                             echo (($position == 0) ? "$currency ".html_escape($tmnt_show)  : html_escape($tmnt_show)." $currency") ?></td>
                                        </tr>
                                        <tr>
                                            <th class="text-left grand_total"><?php echo display('paid_ammount') ?> : </th>
                                            <td class="text-right grand_total"><?php echo (($position == 0) ? "$currency {paid_amount}" : "{paid_amount} $currency") ?></td>
                                        </tr>				 
                                        <?php
                                        if ($invoice_all_data[0]['due_amount'] != 0) {
                                            ?>
                                            <tr>
                                                <th class="text-left grand_total"><?php echo display('due') ?> : </th>
                                                <td  class="text-right grand_total"><?php
                                                 $due = number_format($tmnt - $raw_paid_amount, 2, '.', ',');
                                                 echo (($position == 0) ? "$currency ".html_escape($due) : html_escape($due)." $currency") ?></td>
                                            </tr>
                                            <?php
                                        }
                                        ?>
                                    </table>

		                              

		                        </div>
		                        <input type="hidden" name="" id="url" value="<?php echo base_url('Cinvoice');?>">
	                        </div>
	                        <?php if (!empty($Web_settings[0]['receipt_footer'])) { ?>
	                            <div class="receipt-footer" style="text-align:center; padding:10px;"><?php echo $Web_settings[0]['receipt_footer']; ?></div>
	                        <?php } ?>
	                    </div>
	                </div>

                    
                </div>
                 <div class="panel-footer text-left">
						<button  class="btn btn-info" id="printPageButton" onclick="printDiv('printableArea')"><span class="fa fa-print"></span></button>

                    </div>
            </div>
        </div>
        <?php
        }
        else{
        ?>
            <div class="col-sm-12">
                <div class="panel panel-bd lobidrag">
                    <div class="panel-heading">
                        <div class="panel-title">
                            <h4><?php echo display('You do not have permission to access. Please contact with administrator.');?></h4>
                        </div>
                    </div>
                </div>
            </div>
        <?php
        }
        ?>
    </section> <!-- /.content -->
</div> <!-- /.content-wrapper -->



