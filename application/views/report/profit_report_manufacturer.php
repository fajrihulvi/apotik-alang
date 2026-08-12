 <link href="<?php echo base_url()?>assets/css/select2.min.css" rel="stylesheet" type="text/css"/>
<script src="<?php echo base_url()?>my-assets/js/admin_js/json/manufacturer.js.php" ></script>

<!-- Profit Report Start -->
<div class="content-wrapper">
	<section class="content-header">
	    <div class="header-icon">
	        <i class="pe-7s-note2"></i>
	    </div>
	    <div class="header-title">
	        <h1><?php echo display('profit_report_manufacturer_wise') ?></h1>
	        <small><?php echo display('total_profit_report')?></small>
	        <ol class="breadcrumb">
	            <li><a href="#"><i class="pe-7s-home"></i> <?php echo display('home') ?></a></li>
	            <li><a href="#"><?php echo display('report') ?></a></li>
	            <li class="active"><?php echo display('profit_report_manufacturer_wise') ?></li>
	        </ol>
	    </div>
	</section>

	<section class="content">
		

		<div class="row">
            <div class="col-sm-12">
                
                  <a href="<?php echo base_url('Admin_dashboard/all_report')?>" class="btn btn-info m-b-5 m-r-2"><i class="ti-align-justify"> </i> <?php echo display('todays_report')?> </a>

                  <a href="<?php echo base_url('Admin_dashboard/todays_purchase_report')?>" class="btn btn-success m-b-5 m-r-2"><i class="ti-align-justify"> </i>  <?php echo display('purchase_report')?> </a>

                  <a href="<?php echo base_url('Admin_dashboard/product_sales_reports_date_wise')?>" class="btn btn-primary m-b-5 m-r-2"><i class="ti-align-justify"> </i>  <?php echo display('sales_report_product_wise')?> </a>

                  <a href="<?php echo base_url('Admin_dashboard/todays_sales_report')?>" class="btn btn-warning m-b-5 m-r-2"><i class="ti-align-justify"> </i>  <?php echo display('sales_report')?> </a>

            </div>
        </div>

		<!-- Profit report -->
		<div class="row">
			<div class="col-sm-12">
		        <div class="panel panel-default">
		            <div class="panel-body"> 
		                <?php echo form_open('Admin_dashboard/profit_manufacturer',array('class' => 'form-inline','method' => 'post'))?>
		                <?php date_default_timezone_set("Asia/Dhaka"); $today = date('Y-m-d'); ?>
		                <div class="row">
                            <label for="manufacturer" class="col-sm-3 col-form-label"><?php echo display('manufacturer') ?></label>
                            <div class="col-sm-6">
                                 <select name="manufacturer_id" class="form-control">
                                <option value="">Semua Distributor</option>
                                 <?php foreach($manufacturer as $manufacturers){?>
                                 <option value="<?php echo html_escape($manufacturers['manufacturer_id']);?>" <?php if($manufacturer_id == $manufacturers['manufacturer_id']){echo 'selected';}?>><?php echo html_escape($manufacturers['manufacturer_name']);?></option>
                                 <?php }?>
                             </select>
                            </div>
                        </div>
   
                           <br>
		                    
		                    <div class="row">
		                        <label for="from_date" class="col-sm-3 col-form-label"><?php echo display('start_date') ?>:</label>
		                        <div class="col-sm-6">
		                        <input type="text" name="from_date" class="form-control datepicker" id="from_date" placeholder="<?php echo display('start_date') ?>" value="<?php echo $today?>" >
		                    </div> 
		                </div>
                           <br>
		                    <div class="row">
		                        <label for="to_date" class="col-sm-3 col-form-label"><?php echo display('end_date') ?>:</label>
		                        <div class="col-sm-6">
		                        <input type="text" name="to_date" class="form-control datepicker" id="to_date" placeholder="<?php echo display('end_date') ?>" value="<?php echo $today?>">
		                    </div>
		                    </div>  
		                      <br>
                      <div class="col-sm-8 text-center">
                        <button type="submit" class="btn btn-success"><?php echo display('view_report') ?></button>
                    </div>
                          
		               <?php echo form_close()?>


		            </div>
		            
		        </div>
		    </div>
	    </div>

		<div class="row">
		    <div class="col-sm-12">
		        <div class="panel panel-bd lobidrag">
		            <div class="panel-heading">
		                <div class="panel-title">
		                    <h4><?php echo display('profit_report_manufacturer_wise') ?>
		                    <span class="text-right"><a  class="btn btn-warning" href="#" onclick="printDiv('profit_div')"><?php echo display('print') ?></a>
		                    <a class="btn btn-success" href="<?php echo base_url('Admin_dashboard/profit_manufacturer_excel')?>?from_date=<?php echo urlencode($from) ?>&amp;to_date=<?php echo urlencode($to) ?>&amp;manufacturer_id=<?php echo urlencode($manufacturer_id) ?>"><i class="fa fa-file-excel-o"></i> Download Excel</a></span></h4>
		                </div>
		            </div>
		           
		            <div class="panel-body"  id="profit_div">
		            		<span class="text-left"><img src="<?php echo $logo; ?>" class=""></span>

		            	<span class="text-center">

								{manufacturer_info}
								<h3><?php echo display('report_for') ?>  {manufacturer_name} </h3>
								<h4 >{address} </h4>
								{/manufacturer_info}
							<h4>From {from} To  {to}</h4>	
							</span>

		            	<div>
			            	
							
                       <!-- Rincian per tanggal per distributor -->
                       <div class="table-responsive">
                           <table class="table table-bordered table-striped table-hover">
                               <thead>
                                   <tr>
                                       <th><?php echo display('date') ?></th>
                                       <th>Nama Distributor</th>
                                       <th class="text-center">Total Sell Price</th>
                                       <th class="text-center">Total Purchase Price</th>
                                       <th class="text-center">Gross Margin</th>
                                   </tr>
                               </thead>
                               <tbody>
                               <?php
                               $row_sell = 0;
                               $row_cost = 0;
                               $row_margin = 0;
                               if(!empty($datewise)){
                                   foreach($datewise as $drow){
                                       $row_sell   += $drow['total_sell'];
                                       $row_cost   += $drow['total_cost'];
                                       $row_margin += $drow['gross_margin'];
                               ?>
                                   <tr>
                                       <td><?php echo html_escape($drow['date']);?></td>
                                       <td><?php echo html_escape($drow['manufacturer_name']);?></td>
                                       <td class="text-right"><?php echo number_format($drow['total_sell'], 0, ',', '.');?></td>
                                       <td class="text-right"><?php echo number_format($drow['total_cost'], 0, ',', '.');?></td>
                                       <td class="text-right <?php echo ($drow['gross_margin'] < 0 ? 'text-danger' : '')?>"><?php echo number_format($drow['gross_margin'], 0, ',', '.');?></td>
                                   </tr>
                               <?php
                                   }
                               }else{
                               ?>
                                   <tr><td colspan="5" class="text-center">Tidak ada data pada rentang tanggal ini.</td></tr>
                               <?php } ?>
                               </tbody>
                               <tfoot>
                                   <tr>
                                       <td colspan="2" class="text-right"><b>Total</b></td>
                                       <td class="text-right"><b><?php echo number_format($row_sell, 0, ',', '.');?></b></td>
                                       <td class="text-right"><b><?php echo number_format($row_cost, 0, ',', '.');?></b></td>
                                       <td class="text-right"><b><?php echo number_format($row_margin, 0, ',', '.');?></b></td>
                                   </tr>
                               </tfoot>
                           </table>
                       </div>
<h4> <?php echo display('print_date') ?>: <?php echo date("d/m/Y h:i:s"); ?> </h4>
			            </div>

		            </div>
		            <div></div>
		        </div>
		    </div>
		</div>
	</section>
</div>
 <!-- Profit Report End -->
   