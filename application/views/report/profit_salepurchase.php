
<!-- Profit Report Start -->
<div class="content-wrapper">
	<section class="content-header">
	    <div class="header-icon">
	        <i class="pe-7s-note2"></i>
	    </div>
	    <div class="header-title">
	        <h1><?php echo 'Invoice wise'; ?></h1>
	        <small><?php echo display('report')?></small>
	        <ol class="breadcrumb">
	            <li><a href="#"><i class="pe-7s-home"></i> <?php echo display('home') ?></a></li>
	            <li><a href="#"><?php echo display('report') ?></a></li>
	            <li class="active"><?php echo 'Invoice wise'; ?></li>
	        </ol>
	    </div>
	</section>

	<section class="content">

		<!-- Profit report -->
		<div class="row">
			<div class="col-sm-12">
		        <div class="panel panel-default">
		            <div class="panel-body"> 
		                <div class="row">
		  <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                <div class="panel panel-bd">
                    <div class="panel-body pro-background">
                        <div class="statistic-box">
                             <h3 class="text-center pro-heads">Today's Profit</h3>
                           <table>
                               <tr>
                                   <td class="text-right">
                                    <h4>Total Harga Jual :</h4>
                                    <h4>Total Harga Beli :</h4>
                                    <h4 class="pro-margintop">Gross Margin :</h4>
                                   </td>
                                   <td class="text-right">
                                         <h4><?php echo $currency.' '.number_format($todays['sale_amount'], 0, ',', '.')?></h4> 
                                          <h4><?php echo $currency.' '.number_format($todays['manufacture_amount'], 0, ',', '.')?></h4>
                                          <h4 class="pro-borde-top"><?php echo $currency.' '.number_format($todays['profit'], 0, ',', '.')?></h4>
                                   </td>
                               </tr>
                           </table>
                        </div>
                    </div>
                </div>
            </div>
            		  <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                <div class="panel panel-bd">
                    <div class="panel-body pro-background2">
                        <div class="statistic-box">
                             <h3 class="text-center pro-heads">This Week's Profit</h3>
                           <table>
                               <tr>
                                   <td class="text-right">
                                    <h4>Total Harga Jual :</h4>
                                    <h4>Total Harga Beli :</h4>
                                    <h4 class="pro-margintop">Gross Margin :</h4>
                                   </td>
                                   <td class="text-right">
                                          <h4><?php echo $currency.' '.number_format($weekly['sale_amount'], 0, ',', '.')?></h4> 
                                          <h4><?php echo $currency.' '.number_format($weekly['manufacture_amount'], 0, ',', '.')?></h4>
                                          <h4 class="pro-borde-top"><?php echo $currency.' '.number_format($weekly['profit'], 0, ',', '.')?></h4>
                                   </td>
                               </tr>
                           </table>
                        </div>
                    </div>
                </div>
            </div>
            		  <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                <div class="panel panel-bd">
                    <div class="panel-body pro-background3">
                        <div class="statistic-box">
                             <h3 class="text-center pro-heads">This Month's Profit</h3>
                           <table>
                               <tr>
                                   <td class="text-right">
                                    <h4>Total Harga Jual :</h4>
                                    <h4>Total Harga Beli :</h4>
                                    <h4 class="pro-margintop">Gross Margin :</h4>
                                   </td>
                                   <td class="text-right">
                                         <h4><?php echo $currency.' '.number_format($monthly['sale_amount'], 0, ',', '.')?></h4> 
                                          <h4><?php echo $currency.' '.number_format($monthly['manufacture_amount'], 0, ',', '.')?></h4>
                                          <h4 class="pro-borde-top"><?php echo $currency.' '.number_format($monthly['profit'], 0, ',', '.')?></h4>
                                   </td>
                               </tr>
                           </table>
                        </div>
                    </div>
                </div>
            </div>
		                </div>
		            </div>
		           
		        </div>
		    </div>
	    </div>
     
            <div class="row">
                <div class="col-sm-12">
                    <div class="panel panel-bd lobidrag">
                        <div class="panel-heading">
                            <div class="panel-title">
                             
                            </div>
                        </div>
                        <div class="panel-body" >
                            
                            <div class="row">
                                <div class="text-right">
                                <?php echo form_open('Admin_dashboard/daily_profit',array('class' => 'form-inline','method' => 'post'))?>
		                <?php date_default_timezone_set("Asia/Dhaka"); ?>
		               
                        <div class="form-group">
                            <label for="from_date"><?php echo display('start_date') ?>:</label>
                            <input type="text" name="from_date" class="form-control datepicker" id="from_date" placeholder="<?php echo display('start_date') ?>" value="<?php echo html_escape($start_date)?>" >
                        </div>
                        <div class="form-group">
                            <label for="to_date"><?php echo display('end_date') ?>:</label>
                            <input type="text" name="to_date" class="form-control datepicker" id="to_date" placeholder="<?php echo display('end_date') ?>" value="<?php echo html_escape($end_date)?>">
                        </div>
                        <div class="form-group serach-buttonmargin">
                        <button type="submit" class="btn btn-success"><?php echo display('search') ?></button>
                        <a class="btn btn-success" id="daily_profit_excel_link" href="<?php echo base_url('Admin_dashboard/daily_profit_excel')?>?from_date=<?php echo urlencode($start_date) ?>&amp;to_date=<?php echo urlencode($end_date) ?>"><i class="fa fa-file-excel-o"></i> Download Excel</a>
                      </div>
		               <?php echo form_close()?>

		               <script type="text/javascript">
		               // Ikutkan tanggal yang sedang diisi di form ke tautan unduh,
		               // supaya isi file cocok dengan rentang yang dipilih pengguna
		               // walaupun tombol Cari belum ditekan.
		               (function () {
		                   var link = document.getElementById('daily_profit_excel_link');
		                   if (!link) { return; }
		                   var base = '<?php echo base_url('Admin_dashboard/daily_profit_excel')?>';
		                   link.addEventListener('click', function () {
		                       var from = document.getElementById('from_date');
		                       var to   = document.getElementById('to_date');
		                       var url  = base;
		                       if (from && to && from.value && to.value) {
		                           url += '?from_date=' + encodeURIComponent(from.value)
		                                + '&to_date='   + encodeURIComponent(to.value);
		                       }
		                       link.setAttribute('href', url);
		                   });
		               })();
		               </script>
                              </div>
                              <br>
                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                           
                                            <tr>
                                            <th>Date</th>
                                            <th>Invoice No</th>
                                            <th>Nama Distributor</th>
                                            <th class="text-center">Total Harga Jual</th>
                                            <th class="text-center">Total Harga Beli</th>
                                            <th class="text-center">Gross Margin</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                             <?php
                                             // Nilai jual, modal, dan laba dijumlahkan sambil baris
                                             // dicetak, lalu dipakai lagi pada baris Total di bawah.
                                             // Semua angka diformat seragam (dua desimal) supaya
                                             // kolomnya mudah dibandingkan - sebelumnya nilai jual
                                             // dan modal tercetak apa adanya tanpa format.
                                             $total_sale = 0;
                                             $total_mprice = 0;
                                             $totalprofit = 0;
                             foreach($salepurchase as $result){
                                    // Modal dan distributor sudah dihitung sekali jalan di model.
                                    $info               = (isset($invoice_map[$result['invoice_id']]) ? $invoice_map[$result['invoice_id']] : array('cost' => 0, 'distributor' => '-'));
                                    $manufacturer_price = $info['cost'];
                                    $distributor        = $info['distributor'];
                                    $profit             = $result['total_amount'] - $manufacturer_price;

                                    $total_sale   += $result['total_amount'];
                                    $total_mprice += $manufacturer_price;
                                    $totalprofit  += $profit;
                             ?>
                                            <tr>
                                    <td><?php echo html_escape($result['date']);?></td>
                                    <td><?php echo html_escape($result['invoice']);?></td>
                                    <td><?php echo html_escape($distributor);?></td>
                                    <td class="text-right"><?php echo number_format($result['total_amount'], 0, ',', '.');?></td>
                                    <td class="text-right"><?php echo number_format($manufacturer_price, 0, ',', '.');?></td>
                                    <td class="text-right <?php echo ($profit < 0 ? 'text-danger' : '')?>"><?php echo number_format($profit, 0, ',', '.');?></td>
                                </tr>

                                <?php   }?>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <td colspan="3" class="text-right"><b>Total</b></td>
                                                <td class="text-right"><b><?php echo number_format($total_sale, 0, ',', '.');?></b></td>
                                                <td class="text-right"><b><?php echo number_format($total_mprice, 0, ',', '.');?></b></td>
                                                <td class="text-right"><b><?php echo number_format($totalprofit, 0, ',', '.');?></b></td>
                                            </tr>
                                        </tfoot>
                                        
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
     
	
	</section>
</div>
 <!-- Profit Report End -->
