component {

    property name="pluginConfig";
    property name="configBean";

    public any function init() {
        return this;
    }
    public any function setPluginConfig(pluginConfig) {
        this.pluginConfig = arguments.pluginConfig;
    }
    public any function setConfigBean(configBean) {
        this.configBean = arguments.configBean;
    }
    public any function edit() {

        var datasource = this.configBean.getDatasource();
        request.muraSimplify = {};

        var groupId = "";
        if (structKeyExists(url, "userId")) {
            groupId = url.userId;
        } else if (structKeyExists(form, "userId")) {
            groupId = form.userId;
        }

        var queryService = new Query();
        queryService.setDatasource(datasource);
        queryService.setSql("
            SELECT
                f.featureId,
                f.code,
                f.label,
                f.parentId,
                f.required,
                IF(gf.featureId IS NULL, 0, 1) AS enabled
            FROM
                mura_simplify_feature f
            LEFT JOIN
                mura_simplify_group_feature gf
            ON
                gf.featureId = f.featureId
            AND
                gf.groupId = :groupId
            ORDER BY
                orderNo ASC
        ");
        queryService.addParam(
            name = "groupId",
            value = groupId,
            cfSqlType = "cf_sql_char"
        );
        request.muraSimplify.qFeatures = queryService.execute().getResult();

        this.pluginConfig.addToHtmlHeadQueue("views/user-group/edit.cfm");
    }
};