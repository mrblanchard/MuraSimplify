<cfoutput>
    <link
        rel="stylesheet"
        type="text/css"
        href="/plugins/MuraSimplify/includes/css/main.css" />
    <script>
        var muraSimplify = {
        };
        muraSimplify.features = [
            <cfloop query="request.muraSimplify.qFeatures">
                <cfif request.muraSimplify.qFeatures.currentRow gt 1>
                    ,
                </cfif>
                {
                    featureId: #request.muraSimplify.qFeatures.featureId#,
                    code: "#request.muraSimplify.qFeatures.code#",
                    label: "#request.muraSimplify.qFeatures.label#",
                    parentId: #request.muraSimplify.qFeatures.parentId#,
                    required: #request.muraSimplify.qFeatures.required#,
                    enabled: #request.muraSimplify.qFeatures.enabled#
                }
            </cfloop>
        ];
        muraSimplify.userGroup = {
            isNew: #structKeyExists(
                request.muraSimplify, "newUserGroup") ? 'true': 'false'#
        };
        muraSimplify.userGroup.initFormTabs = function() {
            var $form = $('form[name=form1]');
            $form.removeClass('fieldset-wrap');
            $form.append('\
                <div class="tabbable tabs-left mura-ui">\
                    <ul class="nav nav-tabs tabs initActiveTab">\
                        <li id="tabBasicLI" class="active">\
                            <a href="##tabBasic" data-toggle="tab">\
                                <span>Basic</span>\
                            </a>\
                        </li>\
                        <li id="tabMuraSimplifyLI">\
                            <a href="##tabMuraSimplify" data-toggle="tab">\
                                <span>Mura Simplify</span>\
                            </a>\
                        </li>\
                    </ul>\
                    <div class="tab-content row-fluid">\
                        <div id="tabBasic" class="tab-pane active"></div>\
                        <div id="tabMuraSimplify" class="tab-pane">\
                            <div class="fieldset">\
                                <div class="control-group">\
                                    <div class="span6">\
                                        <label class="control-label">\
                                            Features\
                                        </label>\
                                        <div id="mura-simplify-features">\
                                        </div>\
                                    </div>\
                                </div>\
                            </div>\
                        </div>\
                    </div>\
                </div>\
            ');
            var $tabBasic = $('##tabBasic');
            $tabBasic.append($form.children('.fieldset'));
            $tabBasic.append($form.children('##extendSetBasic'));
            $('.tab-content').append($form.children('.form-actions'));
            $form.append('<input\
                type="hidden"\
                name="muraSimplifyData.isUserGroup"\
                value="1" />\
            ');
        }
        muraSimplify.userGroup.initFormFeatures = function() {
            var $features = $('##mura-simplify-features'),
                name,
                hierarchy = {},
                hierarchyId,
                depth,
                style,
                checked,
                featureId,
                parentId,
                readonly,
                extra,
                label;
            for(var i = 0; i < muraSimplify.features.length; i++) {
                hierarchy[muraSimplify.features[i].featureId] = 
                    muraSimplify.features[i].parentId;
            }
            for(var i = 0; i < muraSimplify.features.length; i++) {
                depth = 0;
                style = '';
                checked = '';
                readonly = '';
                extra = '';
                label = muraSimplify.features[i].label;
                hierarchyId = muraSimplify.features[i].featureId;
                featureId = muraSimplify.features[i].featureId;
                parentId = muraSimplify.features[i].parentId;
                name = 'muraSimplifyData.features.' +
                    muraSimplify.features[i].featureId;

                while (hierarchy[hierarchyId] > 0) {
                    depth ++;
                    hierarchyId = hierarchy[hierarchyId];
                }
                if (depth > 0) {
                    style = 'style="margin-left: ' + (depth * 30) + 'px;"';
                }
                if (muraSimplify.features[i].enabled > 0
                    || muraSimplify.userGroup.isNew) {
                    checked = 'checked="checked"';
                }
                if (muraSimplify.features[i].required > 0) {
                    readonly = 'disabled="disabled"';
                    extra = '\
                        <input\
                            type="hidden"\
                            name="' + name + '"\
                            value="on" />\
                    ';
                }
                $features.append('\
                    <label\
                        class="clearfix mura-simplify-checkbox"\
                        ' + style + '>\
                        <input\
                            type="checkbox"\
                            name="' + name + '"\
                            data-feature-id="' + featureId + '"\
                            data-parent-id="' + parentId + '"\
                            ' + readonly + '\
                            ' + checked + ' />\
                        <span>' + label + '</span>\
                        ' + extra + '\
                    </label>\
                ');
            }
        }
        muraSimplify.userGroup.initFormFeatureRules = function() {
            $('.mura-simplify-checkbox input').on('change', function() {
                var $this = $(this);
                var parentId = $this.attr('data-parent-id');
                var $parent = $('[data-feature-id="' + parentId + '"]');
                if ($this.is(':checked')) {

                    // Check the parent
                    if (!$parent.is(':checked')) {
                        $parent.prop('checked', true);
                        $parent.trigger('change');
                    }

                } else {

                    var featureId = $this.attr('data-feature-id');
                    var $siblings = $('[data-parent-id="' + parentId + '"]');
                    var $children = $('[data-parent-id="' + featureId + '"]');

                    // If all siblings are unchecked, uncheck the parent
                    if ($siblings.filter(':checked').length < 1) {

                        if ($parent.is(':checked')) {
                            $parent.prop('checked', false);
                            $parent.trigger('change');
                        }
                    }

                    // Uncheck all children
                    $children.filter(':checked').each(function() {
                        var $child = $(this);
                        $child.prop('checked', false);
                        $child.trigger('change');
                    });
                }
            });
        }

        $(document).ready(function() {
            muraSimplify.userGroup.initFormTabs();
            muraSimplify.userGroup.initFormFeatures();
            muraSimplify.userGroup.initFormFeatureRules();
        });
    </script>
</cfoutput>