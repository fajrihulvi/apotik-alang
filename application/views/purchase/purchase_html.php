<?php
    $CI =& get_instance();
    $CI->load->model('Web_settings');
    $Web_settings = $CI->Web_settings->retrieve_setting_editdata();
?>



<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="header-icon">
            <i class="pe-7s-note2"></i>
        </div>
        <div class="header-title">
            <h1><?php echo display('purchase_detail') ?></h1>
            <small><?php echo display('purchase_detail') ?></small>
            <ol class="breadcrumb">
                <li><a href="#"><i class="pe-7s-home"></i> <?php echo display('home') ?></a></li>
                <li><a href="#"><?php echo display('invoice') ?></a></li>
                <li class="active"><?php echo display('purchase_detail') ?></li>
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
        if($this->permission1->method('manage_purchase','read')->access() ){ ?>
        <div class="row">
            <div class="col-sm-12">
                <div class="panel panel-bd">
	                <div id="printableArea">
	                    <div class="panel-body">
	                        <div class="row">
	                        	{company_info}
	                            <div class="col-sm-8 purchasedetails-address">
	                                <span class="label label-success-outline m-r-15 p-10" ><?php echo display('billing_from') ?></span>
	                                <address class="margin-top10">
	                                    <strong>{company_name}</strong><br>
	                                    {address}<br>
	                                    <abbr><b><?php echo display('mobile') ?>:</b></abbr> {mobile}<br>
	                                    <abbr><b><?php echo display('email') ?>:</b></abbr>
	                                    {email}<br>
	                                    <abbr><b><?php echo display('website') ?>:</b></abbr>
	                                    {website}
	                                    {/company_info}<br>
	                                  
	                                </address>
	                            </div>
	                            
	                            
	                            <div class="col-sm-4 text-left invoice-address">
	                                <h2 class="m-t-0"><?php echo display('purchase') ?></h2>
	                                <div><?php echo display('voucher_no') ?>: <?php echo $purchase[0]['chalan_no'];?></div>
	                                 <div><?php echo display('purchase_id') ?>: <?php echo $purchase[0]['purchase_id'];?></div>
	                                <div class="m-b-15"><?php echo display('billing_date') ?>: <?php echo $purchase[0]['purchase_date'];?></div>

	                                <span class="label label-success-outline m-r-15"><?php echo display('billing_to') ?></span>

	                                  <address class="customer_name_p">
	                                    <strong><?php echo $manufacturer_info[0]['manufacturer_name']?> </strong><br>
	                                    <?php if ($manufacturer_info[0]['address']) { ?>
		                                
		                                <?php echo html_escape($manufacturer_info[0]['address']);} ?>
	                                    <br>
	                                    <abbr><b><?php echo display('mobile') ?>:</b></abbr>
	                                    <?php if ($manufacturer_info[0]['mobile']) { ?>
	                                   
	                                    <?php echo html_escape($manufacturer_info[0]['mobile']);}
	                                    ?>
	                                   
	                                </address>
	                            </div>
	                        </div> <hr>

	                        <div class="table-responsive m-b-20">
	                            <table class="table table-striped table-bordered">
	                                <thead>
	                                    <tr>
	                                        <th class="text-center"><?php echo display('sl') ?></th>
	                                        <th class="text-center"><?php echo display('product_name') ?></th>
	                                        <th class="text-center"><?php echo display('quantity') ?></th>
	                                        <th class="text-center"><?php echo display('purchase_price') ?></th>
	                                        <th class="text-center">Status</th>
	                                        <th class="text-center"><?php echo display('ammount') ?></th>
	                                    </tr>
	                                </thead>
	                                <tbody>
									<?php
									$sub_total = 0;
									$subqty = 0;
									$sl = 1;
									 foreach($details as $purdetails){?>
										<tr>
	                                    	<td class="text-center"><?php echo $sl;?></td>
	                                        <td class="text-center"><div><strong><?php echo medicine_name(html_escape($purdetails['product_name']),html_escape($purdetails['strength']),' - ');
	                                        if($purdetails['quantity'] < 0){
	                                        	echo '('.' <span class="text-danger">Returned</span> '.')';
	                                        }
	                                        ?></strong></div></td>
	                                        <td align="center"><?php if($purdetails['quantity'] < 0){ echo -1*$purdetails['quantity'];}else{
	                                        	echo html_escape($purdetails['quantity']);
	                                        }
	                                        $subqty += $purdetails['quantity'];
	                                         ?></td>

	                                        <td align="center"><?php echo (($position==0)?$currency.' '.$purdetails['rate']:$purdetails['rate'].' '. $currency) ?></td>
	                                        <td align="center"><?php
	                                        // Status harga dibanding pembelian sebelumnya
	                                        // untuk obat + distributor yang sama.
	                                        $ps = (isset($price_status[$purdetails['product_id']])
	                                                ? $price_status[$purdetails['product_id']] : null);
	                                        if (empty($ps) || $ps['status'] == 'baru') {
	                                            echo '<span class="label" style="background:#777;color:#fff;">'
	                                               . '<i class="fa fa-star-o"></i> Baru</span>';
	                                        } else {
	                                            $prev_show = number_format($ps['prev_rate'], 2, '.', ',');
	                                            if ($ps['status'] == 'naik') {
	                                                echo '<span class="label" style="background:#d9534f;color:#fff;" title="Sebelumnya '.$prev_show.'">'
	                                                   . '<i class="fa fa-arrow-up"></i> Naik</span>';
	                                            } elseif ($ps['status'] == 'turun') {
	                                                echo '<span class="label" style="background:#5cb85c;color:#fff;" title="Sebelumnya '.$prev_show.'">'
	                                                   . '<i class="fa fa-arrow-down"></i> Turun</span>';
	                                            } else {
	                                                echo '<span class="label" style="background:#f0ad4e;color:#fff;" title="Sebelumnya '.$prev_show.'">'
	                                                   . '<i class="fa fa-minus"></i> Sama</span>';
	                                            }
	                                        }
	                                        ?></td>
	                                        <td align="right"><?php
                                             if($purdetails['total_amount'] < 0){
                                             	$t_amount = number_format($purdetails['total_amount'] * -1, 2, '.', ',');
                                             }else{
                                             	$t_amount = number_format($purdetails['total_amount'], 2, '.', ',');
                                             }
	                                         echo (($position==0)?$currency.' '.$t_amount:$t_amount.' '. $currency);
	                                        $sub_total += $purdetails['total_amount'];  ?></td>
	                                    </tr>
	                                  <?php $sl++;}?>
	                                </tbody>
	                                <tfoot>
	                                	<td align="center" colspan="1"><b><?php echo display('sub_total')?>:</b></td>
	                                	<td></td>
	                                	<td align="center" ><b><?php echo $subqty;?></b></td>
	                                	<td></td>
	                                	<td></td>
	                                	<td class="text-right" align="center" ><b><?php echo (($position==0)?$currency.' '. $sub_total:$sub_total.' '.$currency) ?></b></td>
	                                </tfoot>
	                            </table>
	                        </div>
	                        <div class="row">

		                        	<div class="col-xs-8 invoicefooter-content">

		                                <p></p>
		                                <p><strong><?php echo html_escape($purchase[0]['purchase_details']);?></strong></p>
		                               
		                            </div>
		                            <div class="col-xs-4 inline-block">

				                        <table class="table">
                                        <?php
                                        if ($purchase[0]['total_discount'] != '') {
                                            ?>
                                            <tr>
                                                <th><?php echo display('total_discount') ?> : </th>
                                                <td class="text-right"><?php echo (($position == 0) ? $currency .' '.$purchase[0]['total_discount'] : $purchase[0]['total_discount'].' '. $currency); ?> </td>
                                            </tr>
                                        <?php }

                                        // Diskon keseluruhan dan PPN. isset() dipakai supaya nota lama
                                        // (tersimpan sebelum fitur ini ada) tetap bisa dicetak.
                                        $od_amount = (isset($purchase[0]['overall_discount_amount'])
                                                      ? (float) $purchase[0]['overall_discount_amount'] : 0);
                                        $ppn_amount = (isset($purchase[0]['ppn_amount'])
                                                       ? (float) $purchase[0]['ppn_amount'] : 0);

                                        if ($od_amount > 0) {
                                            $od_type  = (isset($purchase[0]['overall_discount_type'])
                                                         ? $purchase[0]['overall_discount_type'] : 'percent');
                                            $od_input = (isset($purchase[0]['overall_discount_input'])
                                                         ? (float) $purchase[0]['overall_discount_input'] : 0);
                                            $od_label = display('overall_discount');
                                            if ($od_type === 'percent') {
                                                $od_label .= ' ('.rtrim(rtrim(number_format($od_input, 2, '.', ''), '0'), '.').'%)';
                                            }
                                            ?>
                                            <tr>
                                                <th><?php echo $od_label; ?> : </th>
                                                <td class="text-right">- <?php echo (($position == 0) ? $currency.' '.number_format($od_amount, 2, '.', ',') : number_format($od_amount, 2, '.', ',').' '.$currency); ?></td>
                                            </tr>
                                        <?php }

                                        if ($ppn_amount > 0) {
                                            $ppn_type  = (isset($purchase[0]['ppn_type'])
                                                          ? $purchase[0]['ppn_type'] : 'percent');
                                            $ppn_input = (isset($purchase[0]['ppn_input'])
                                                          ? (float) $purchase[0]['ppn_input'] : 0);
                                            $ppn_label = display('ppn');
                                            if ($ppn_type === 'percent') {
                                                $ppn_label .= ' ('.rtrim(rtrim(number_format($ppn_input, 2, '.', ''), '0'), '.').'%)';
                                            }
                                            ?>
                                            <tr>
                                                <th><?php echo $ppn_label; ?> : </th>
                                                <td class="text-right">+ <?php echo (($position == 0) ? $currency.' '.number_format($ppn_amount, 2, '.', ',') : number_format($ppn_amount, 2, '.', ',').' '.$currency); ?></td>
                                            </tr>
                                        <?php }

                                        // Grand total ditampilkan bila ada diskon atau PPN,
                                        // supaya jelas angka akhir yang dibayar.
                                        if ($od_amount > 0 || $ppn_amount > 0) { ?>
                                            <tr>
                                                <th><?php echo display('grand_total') ?> : </th>
                                                <td class="text-right"><b><?php echo (($position == 0) ? $currency.' '.number_format((float)$purchase[0]['grand_total_amount'], 2, '.', ',') : number_format((float)$purchase[0]['grand_total_amount'], 2, '.', ',').' '.$currency); ?></b></td>
                                            </tr>
                                        <?php }?>
                                           
                                      
                                    </table>

		                              

		                        </div>
		                        <div class="row paddin5ps">
		                        	<div class="col-sm-6">
		                        		 <div class="inv-footer-left">
												<?php echo display('received_by') ?>
										</div>
		                        	</div>
		                        	
		                        	<div class="col-sm-6">  <div class="inv-footer-right">
												<?php echo display('authorised_by') ?>
										</div></div>
		                        </div>
	                        </div>
	                    </div>
	                </div>

                     <div class="panel-footer text-left">
                     	<a  class="btn btn-danger" href="<?php echo base_url('Cinvoice');?>"><?php echo display('cancel') ?></a>
						<button  class="btn btn-info" onclick="printDiv('printableArea')"><span class="fa fa-print"></span></button>
						<a class="btn btn-success" href="<?php echo base_url('Cpurchase/invoice_excel/'.rawurlencode($purchase[0]['purchase_id'])); ?>"><i class="fa fa-file-excel-o"></i> <?php echo display('download') ?> Excel</a>

                    </div>
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



