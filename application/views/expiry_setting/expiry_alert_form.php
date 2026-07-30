<!-- Expiry Alert Setting start -->
<div class="content-wrapper">
    <section class="content-header">
        <div class="header-icon">
            <i class="pe-7s-clock"></i>
        </div>
        <div class="header-title">
            <h1><?php echo display('expiry_alert_setting') ?></h1>
            <small><?php echo display('expiry_alert_setting') ?></small>
            <ol class="breadcrumb">
                <li><a href="#"><i class="pe-7s-home"></i> <?php echo display('home') ?></a></li>
                <li><a href="#"><?php echo display('master_data') ?></a></li>
                <li class="active"><?php echo display('expiry_alert_setting') ?></li>
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

        <?php
        if($this->permission1->method('expiry_alert_setting', 'read')->access() || $this->permission1->method('expiry_alert_setting', 'update')->access()){
        ?>
        <div class="row">
            <div class="col-sm-12">
                <div class="panel panel-bd lobidrag">
                    <div class="panel-heading">
                        <div class="panel-title">
                            <h4><?php echo display('expiry_alert_setting') ?></h4>
                        </div>
                    </div>

                    <div class="panel-body">
                        <?php echo form_open('Cexpiry_setting/update_expiry_alert', 'class="form-horizontal"') ?>

                            <div class="form-group row">
                                <label for="expiry_alert_months" class="col-sm-3 control-label"><?php echo display('expiry_alert_months') ?></label>
                                <div class="col-sm-6">
                                    <input class="form-control" name="expiry_alert_months" id="expiry_alert_months" type="number" min="1" placeholder="8" value="<?php echo html_escape(!empty($setting[0]['expiry_alert_months']) ? $setting[0]['expiry_alert_months'] : 8); ?>">
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-sm-offset-3 col-sm-6">
                                    <?php if($this->permission1->method('expiry_alert_setting', 'update')->access()){ ?>
                                        <button type="submit" class="btn btn-success"><span class="fa fa-save"></span> <?php echo display('save') ?></button>
                                    <?php } ?>
                                </div>
                            </div>

                        <?php echo form_close() ?>
                    </div>
                </div>
            </div>
        </div>
        <?php } else { ?>
            <div class="col-sm-12">
                <div class="panel panel-bd lobidrag">
                    <div class="panel-heading">
                        <div class="panel-title">
                            <h4><?php echo display('You do not have permission to access. Please contact with administrator.') ?></h4>
                        </div>
                    </div>
                </div>
            </div>
        <?php } ?>

    </section>
</div>
