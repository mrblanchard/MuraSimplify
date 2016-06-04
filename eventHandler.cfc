component accessors=true extends='mura.plugin.pluginGenericEventHandler' output=false {

    public any function onGlobalRequestStart($) {
        if (cgi.script_name == "/admin/index.cfm") {
        }
    }

}