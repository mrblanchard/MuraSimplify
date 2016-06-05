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

        var queryService = new Query();
        queryService.setDatasource(datasource);
        queryService.setSql("
            SELECT
                featureId,
                code,
                label,
                parentId,
                required
            FROM
                mura_simplify_feature
            ORDER BY
                orderNo ASC
        ");
        request.muraSimplify.qFeatures = queryService.execute().getResult();

        this.pluginConfig.addToHtmlHeadQueue("views/user-group/edit.cfm");
    }
};