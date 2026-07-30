<!-- Receipt Header & Footer setting start -->

<!-- Summernote assets (belum dimuat di template utama, jadi dimuat di sini) -->
<link href="<?php echo base_url('assets/plugins/summernote/summernote.css') ?>" rel="stylesheet" type="text/css"/>
<script src="<?php echo base_url('assets/plugins/summernote/summernote.js') ?>"></script>
<script src="<?php echo base_url('assets/plugins/summernote/lang/summernote-id-ID.js') ?>"></script>

<div class="content-wrapper">
    <section class="content-header">
        <div class="header-icon">
            <i class="pe-7s-note2"></i>
        </div>
        <div class="header-title">
            <h1><?php echo display('receipt_header_footer') ?></h1>
            <small><?php echo display('receipt_header_footer') ?></small>
            <ol class="breadcrumb">
                <li><a href="#"><i class="pe-7s-home"></i> <?php echo display('home') ?></a></li>
                <li><a href="#"><?php echo display('master_data') ?></a></li>
                <li class="active"><?php echo display('receipt_header_footer') ?></li>
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
        if($this->permission1->method('receipt_header_footer', 'read')->access() || $this->permission1->method('receipt_header_footer', 'update')->access()){
        ?>
        <div class="row">
            <div class="col-sm-12">
                <div class="panel panel-bd lobidrag">
                    <div class="panel-heading">
                        <div class="panel-title">
                            <h4><?php echo display('receipt_header_footer') ?></h4>
                        </div>
                    </div>

                    <div class="panel-body">
                        <?php echo form_open('Creceipt_setting/update_header_footer', 'class="form-horizontal"') ?>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><?php echo display('receipt_header') ?></label>
                                <div class="col-sm-10">
                                    <textarea class="summernote" name="receipt_header"><?php echo (!empty($setting[0]['receipt_header']) ? $setting[0]['receipt_header'] : ''); ?></textarea>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><?php echo display('receipt_footer') ?></label>
                                <div class="col-sm-10">
                                    <textarea class="summernote" name="receipt_footer"><?php echo (!empty($setting[0]['receipt_footer']) ? $setting[0]['receipt_footer'] : ''); ?></textarea>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">
                                    <?php if($this->permission1->method('receipt_header_footer', 'update')->access()){ ?>
                                        <button type="submit" class="btn btn-success"><span class="fa fa-save"></span> <?php echo display('save') ?></button>
                                    <?php } ?>
                                </div>
                            </div>

                        <?php echo form_close() ?>
                    </div>
                </div>
            </div>
        </div>

        <script type="text/javascript">
            $(document).ready(function () {
                if ($.fn.summernote) {
                    $('.summernote').summernote({
                        height: 180,
                        lang: 'id-ID',
                        toolbar: [
                            ['style', ['bold', 'italic', 'underline', 'clear']],
                            ['font', ['fontsize']],
                            ['para', ['ul', 'ol', 'paragraph']],
                            ['insert', ['picture', 'link']],
                            ['view', ['codeview']]
                        ]
                    });
                }
            });
        </script>

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
