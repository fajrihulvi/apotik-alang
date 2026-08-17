<!-- Detail Stock Opname -->
<div class="content-wrapper">
	<section class="content-header">
	    <div class="header-icon">
	        <i class="pe-7s-note2"></i>
	    </div>
	    <div class="header-title">
	        <h1><?php echo display('stock_opname') ?></h1>
	        <small><?php echo html_escape($header['opname_no']) ?></small>
	        <ol class="breadcrumb">
	            <li><a href="#"><i class="pe-7s-home"></i> <?php echo display('home') ?></a></li>
	            <li><a href="<?php echo base_url('Cstock_opname') ?>"><?php echo display('opname_list') ?></a></li>
	            <li class="active"><?php echo html_escape($header['opname_no']) ?></li>
	        </ol>
	    </div>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-sm-12">
				<div class="panel panel-bd lobidrag">
					<div class="panel-heading">
						<div class="panel-title">
							<h4><?php echo html_escape($header['opname_no']) ?>
								<?php if ($header['status'] == 1) { ?>
									<span class="label label-success"><?php echo display('opname_posted') ?></span>
								<?php } else { ?>
									<span class="label label-warning"><?php echo display('opname_draft') ?></span>
								<?php } ?>
							</h4>
						</div>
					</div>
					<div class="panel-body">

						<div class="row">
							<div class="col-sm-3">
								<b><?php echo display('date') ?>:</b><br>
								<?php echo html_escape($header['tanggal_tampil']) ?>
							</div>
							<div class="col-sm-2">
								<b><?php echo display('adjusted_time') ?>:</b><br>
								<?php echo html_escape(substr($header['opname_time'],0,5)) ?>
							</div>
							<div class="col-sm-3">
								<b><?php echo display('adjusted_by') ?>:</b><br>
								<?php echo html_escape(trim($header['nama_pembuat'])) ?>
							</div>
							<div class="col-sm-4">
								<b><?php echo display('opname_note') ?>:</b><br>
								<?php echo html_escape($header['note']) ?>
							</div>
						</div>

						<?php if ($header['status'] == 1) { ?>
						<div class="row" style="margin-top:10px;">
							<div class="col-sm-12">
								<div class="alert alert-success" style="margin-bottom:0;">
									<?php echo display('post_opname') ?>:
									<b><?php echo html_escape(trim($header['nama_poster'])) ?></b>
									&mdash; <?php echo html_escape($header['posted_at']) ?>
								</div>
							</div>
						</div>
						<?php } ?>

					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-sm-12">
				<div class="panel panel-bd lobidrag">
					<div class="panel-body">
						<div class="table-responsive">
							<table class="table table-striped table-bordered">
								<thead>
									<tr>
										<th><?php echo display('product_name') ?></th>
										<th class="text-center"><?php echo display('unit') ?></th>
										<th class="text-right"><?php echo display('qty_system') ?></th>
										<th class="text-right"><?php echo display('qty_physical') ?></th>
										<th class="text-right"><?php echo display('qty_difference') ?></th>
										<th><?php echo display('opname_reason') ?></th>
										<th><?php echo display('reason_note') ?></th>
										<th><?php echo display('adjusted_time') ?></th>
									</tr>
								</thead>
								<tbody>
								<?php if (!empty($details)) { foreach ($details as $d) { ?>
									<tr>
										<td><?php echo html_escape(trim($d['product_name'].' '.$d['strength'])) ?></td>
										<td class="text-center"><?php echo html_escape($d['unit']) ?></td>
										<td class="text-right"><?php echo html_escape($d['qty_system']) ?></td>
										<td class="text-right"><?php echo html_escape($d['qty_physical']) ?></td>
										<td class="text-right" style="color:<?php echo ($d['qty_difference'] < 0 ? '#a94442' : '#3c763d') ?>">
											<b><?php echo ($d['qty_difference'] > 0 ? '+' : '').html_escape($d['qty_difference']) ?></b>
										</td>
										<td><?php echo display('reason_'.$d['reason_code']) ?></td>
										<td><?php echo html_escape($d['reason_note']) ?></td>
										<td><?php echo html_escape(substr($d['adjusted_time'],0,5)) ?></td>
									</tr>
								<?php } } else { ?>
									<tr><td colspan="8" class="text-center">-</td></tr>
								<?php } ?>
								</tbody>
								<tfoot>
									<tr>
										<th colspan="4" class="text-right"><?php echo display('total') ?>:</th>
										<th class="text-right"><?php echo ($header['total_selisih'] > 0 ? '+' : '').html_escape($header['total_selisih']) ?></th>
										<th colspan="3"><?php echo html_escape($header['total_item']) ?> item</th>
									</tr>
								</tfoot>
							</table>
						</div>

						<div class="row" style="margin-top:15px;">
							<div class="col-sm-12 text-right">
								<a href="<?php echo base_url('Cstock_opname') ?>" class="btn btn-default"><?php echo display('opname_list') ?></a>
								<?php if ($header['status'] == 0) { ?>
									<a href="<?php echo base_url('Cstock_opname/post_opname/'.$header['id']) ?>"
									   class="btn btn-success"
									   onclick="return confirm('<?php echo display('post_opname') ?>? <?php echo display('opname_posted') ?>.')">
										<i class="fa fa-check"></i> <?php echo display('post_opname') ?>
									</a>
								<?php } ?>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</section>
</div>
