component {

    property name="pluginConfig";
    property name="configBean";
    property name="$";

    public any function init() {
        return this;
    }

    public any function setPluginConfig(pluginConfig) {
        this.pluginConfig = arguments.pluginConfig;
    }

    public any function setConfigBean(configBean) {
        this.configBean = arguments.configBean;
    }

    public any function set$($) {
        this.$ = arguments.$;
    }

};