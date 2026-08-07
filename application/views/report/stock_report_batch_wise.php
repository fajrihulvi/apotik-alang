

<!-- Stock List manufacturer Wise Start -->
<div class="content-wrapper">
	<section class="content-header">
	    <div class="header-icon">
	        <i class="pe-7s-note2"></i>
	    </div>
	    <div class="header-title">
	        <h1><?php echo display('stock_report_batch_wise') ?></h1>
	        <small><?php echo display('stock_report_batch_wise') ?></small>
	        <ol class="breadcrumb">
	            <li><a href="#"><i class="pe-7s-home"></i> <?php echo display('home') ?></a></li>
	            <li><a href="#"><?php echo display('stock') ?></a></li>
	            <li class="active"><?php echo display('stock_report_batch_wise') ?></li>
	        </ol>
	    </div>
	</section>

	<section class="content">

		<div class="row">
            <div class="col-sm-12">
               

                    <?php
                    if($this->permission1->method('stock_report','read')->access()){ ?>
                        <a href="<?php echo base_url('Creport')?>" class="btn btn-primary m-b-5 m-r-2"><i class="ti-align-justify"> </i>  <?php echo display('stock_report')?> </a>
                    <?php } ?>
              
            </div>
        </div>

        <?php
        if($this->permission1->method('stock_report_batch_wise','read')->access()){ ?>
	
		<!-- Filter: beberapa nama barang / beberapa faktur pembelian -->
		<div class="row">
		    <div class="col-sm-12">
		        <div class="panel panel-default">
		            <div class="panel-body">
		                <div class="col-sm-5">
		                    <div class="form-group">
		                        <label for="filter_product_batch"><?php echo display('product_name') ?></label>
		                        <select id="filter_product_batch" class="form-control" multiple="multiple" data-placeholder="<?php echo display('product_name') ?>"></select>
		                    </div>
		                </div>
		                <div class="col-sm-5">
		                    <div class="form-group">
		                        <label for="filter_purchase_batch">Faktur Pembelian</label>
		                        <select id="filter_purchase_batch" class="form-control" multiple="multiple" data-placeholder="Faktur Pembelian"></select>
		                    </div>
		                </div>
		                <div class="col-sm-12">
		                    <button type="button" id="btn-batch-filter" class="btn btn-success"><?php echo display('find') ?></button>
		                    <button type="button" id="btn-batch-filter-reset" class="btn btn-default">Reset</button>
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
		                    <h4><?php echo display('stock_report_batch_wise') ?></h4>
		                </div>
		            </div>
		            <div class="panel-body">
						<div id="printableArea">

			                <div class="table-responsive">
			                     <table class="table table-striped table-bordered" cellspacing="0" width="100%" id="batchStock">
			                        <thead>
										<tr>
											<th class="text-center"><?php echo display('sl') ?></th>
											<th class="text-center"><?php echo display('product_name') ?></th>
											<th class="text-center"><?php echo display('strength') ?></th>
											<th class="text-center"><?php echo display('batch_id') ?></th>
											<th class="text-center"><?php echo display('expire_date') ?></th>
											<th class="text-center"><?php echo display('in_qnty') ?></th>
											<th class="text-center"><?php echo display('out_qnty') ?></th>
											<th class="text-center"><?php echo display('stock') ?></th>
										</tr>
									</thead>
									<tbody>
										
									</tbody>
									
			                    </table>
			                </div>
			            </div>
		     <input type="hidden" id="currency" value="{currency}" name="">
		            </div>
		        </div>
		    </div>
		</div>
        <?php } ?>
	</section>
</div>
