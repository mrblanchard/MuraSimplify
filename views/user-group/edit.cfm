<cfoutput>
    <link
        rel="stylesheet"
        type="text/css"
        href="/plugins/MuraSimplify/includes/css/main.css" />
    <script>
        var muraSimplify = {
            features: [
                <cfloop query="request.muraSimplify.qFeatures">
                    <cfif request.muraSimplify.qFeatures.currentRow gt 1>
                        ,
                    </cfif>
                    {
                        featureId: #request.muraSimplify.qFeatures.featureId#,
                        code: "#request.muraSimplify.qFeatures.code#",
                        label: "#request.muraSimplify.qFeatures.label#",
                        parentId: #request.muraSimplify.qFeatures.parentId#,
                        required: #request.muraSimplify.qFeatures.required#
                    }
                </cfloop>
            ]
        };
        $(document).ready(function() {
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
            $features = $('##mura-simplify-features');
            var name,
                hierarchy = {},
                hierarchyId,
                depth,
                style;
            for(var i = 0; i < muraSimplify.features.length; i++) {
                hierarchy[muraSimplify.features[i].featureId] = 
                    muraSimplify.features[i].parentId;
            }
            for(var i = 0; i < muraSimplify.features.length; i++) {
                depth = 0;
                style = '';
                hierarchyId = muraSimplify.features[i].featureId;
                while (hierarchy[hierarchyId] > 0) {
                    depth ++;
                    hierarchyId = hierarchy[hierarchyId];
                }
                name = 'muraSimplifyData.features.' +
                    muraSimplify.features[i].featureId;
                if (depth > 0) {
                    style = ' style="margin-left: ' + (depth * 30) + 'px;"';
                }
                $features.append('\
                    <label class="clearfix mura-simplify-checkbox"\
                        ' + style + '>\
                        <input\
                            type="checkbox"\
                            name="' + name + '"\
                            checked="checked" />\
                        <span>' + muraSimplify.features[i].label + '</span>\
                    </label>\
                ');
            }
        });
    </script>
</cfoutput>
