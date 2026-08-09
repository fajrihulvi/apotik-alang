<!-- Near Expiry Medicine List Start -->
<div class="content-wrapper">
	<section class="content-header">
	    <div class="header-icon">
	        <i class="pe-7s-clock"></i>
	    </div>
	    <div class="header-title">
	        <h1><?php echo display('near_expiry') ?></h1>
	        <small><?php echo display('near_expiry_list') ?></small>
	        <ol class="breadcrumb">
	            <li><a href="#"><i class="pe-7s-home"></i> <?php echo display('home') ?></a></li>
	            <li><a href="#"><?php echo display('stock') ?></a></li>
	            <li class="active"><?php echo display('near_expiry_list') ?></li>
	        </ol>
	    </div>
	</section>

	<section class="content">

		<div class="row">
		    <div class="col-sm-12">
		        <div class="panel panel-bd lobidrag">
		            <div class="panel-heading">
		                <div class="panel-title">
		                    <h4><?php echo display('near_expiry_list') ?></h4>
		                </div>
		            </div>
		            <div class="panel-body">
		                <div class="table-responsive">
		                     <table class="table table-striped table-bordered" cellspacing="0" width="100%" id="nearExpiry">
		                        <thead>
									<tr>
										<th class="text-center"><?php echo display('sl') ?></th>
										<th class="text-center"><?php echo display('product_name') ?></th>
										<th class="text-center"><?php echo display('manufacturer_name') ?></th>
										<th class="text-center"><?php echo display('batch_id') ?></th>
										<th class="text-center"><?php echo display('expeire_date') ?></th>
										<th class="text-center"><?php echo display('days_left') ?></th>
										<th class="text-center"><?php echo display('urgency') ?></th>
										<th class="text-center"><?php echo display('stock') ?></th>
									</tr>
								</thead>
								<tbody>

								</tbody>
		                    </table>
		                </div>

		                <div class="text-center">

		                </div>
		            </div>
		        </div>
		    </div>
		</div>
	</section>
</div>
