<!-- Payment type list start -->
<div class="content-wrapper">
    <section class="content-header">
        <div class="header-icon">
            <i class="pe-7s-cash"></i>
        </div>
        <div class="header-title">
            <h1><?php echo display('payment_type') ?></h1>
            <small><?php echo display('payment_type_list') ?></small>
            <ol class="breadcrumb">
                <li><a href="#"><i class="pe-7s-home"></i> <?php echo display('home') ?></a></li>
                <li><a href="#"><?php echo display('payment_type') ?></a></li>
                <li class="active"><?php echo display('payment_type_list') ?></li>
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

        <div class="row">
            <div class="col-sm-12">
                <div class="panel panel-bd lobidrag">
                    <div class="panel-heading">
                        <div class="panel-title">
                            <h4><?php echo display('payment_type_list') ?></h4>
                        </div>
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table id="dataTableExample2" class="table table-bordered table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th class="text-center"><?php echo display('payment_type_name') ?></th>
                                        <th class="text-center"><?php echo display('status') ?></th>
                                        <?php
                                          if ($this->permission1->method('payment_type_list', 'update')->access() || $this->permission1->method('payment_type_list', 'delete')->access()){
                                        ?>
                                            <th class="text-center"><?php echo display('action') ?></th>
                                        <?php
                                          }
                                        ?>
                                    </tr>
                                </thead>
                                <tbody>
                                <?php
                                   foreach($payment_type as $row){
                                ?>
                                    <tr>
                                        <td class="text-center"><?php echo html_escape($row['payment_type_name'])?></td>
                                        <td class="text-center">
                                            <?php if ($row['status'] == 1){ ?>
                                                <span class="label label-success"><?php echo display('active') ?></span>
                                            <?php } else { ?>
                                                <span class="label label-danger"><?php echo display('inactive') ?></span>
                                            <?php } ?>
                                        </td>
                                        <?php
                                        if ($this->permission1->method('payment_type_list', 'update')->access() || $this->permission1->method('payment_type_list', 'delete')->access()){
                                        ?>
                                        <td>
                                            <center>
                                                <?php
                                                if ($this->permission1->method('payment_type_list', 'update')->access()){
                                                ?>
                                                  <a href="<?php echo base_url().'Cpayment_type/payment_type_form/'.$row['id']; ?>" class="btn btn-info btn-sm" data-toggle="tooltip" data-placement="left" title="<?php echo display('update') ?>"><i class="fa fa-pencil" aria-hidden="true"></i></a>
                                                <?php }?>

                                                <?php
                                                if ($this->permission1->method('payment_type_list', 'delete')->access()){
                                                ?>
                                                <a onclick="return confirm('Are You Sure to Want To Delete ?')" href="<?php echo base_url().'Cpayment_type/delete_payment_type/'.$row['id']; ?>" class="btn btn-danger btn-sm" data-original-title="<?php echo display('delete') ?> "><i class="fa fa-trash-o" aria-hidden="true"></i></a>
                                                <?php }?>
                                            </center>
                                        </td>
                                        <?php } ?>
                                    </tr>
                                <?php
                                    }
                                ?>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </section>
</div>
