component extends="mura.plugin.pluginGenericEventHandler"  {

    public any function onGlobalRequestStart($) {

        var muraAction = "";
        if (structKeyExists(url, "muraAction")) {
            muraAction = url.muraAction;
        } else if (structKeyExists(form, "muraAction")) {
            muraAction = form.muraAction;
        }

        var actions = {
            "cPrivateUsers.editgroup": {
                controller: "UserGroup" ,
                method: "edit"
            },
            "cPrivateUsers.update": {
                controller: "UserGroup",
                method: "save"
            }
        };

        if (structKeyExists(actions, muraAction)) {
            var controller = createObject(
                "component",
                "controllers." & actions[muraAction].controller
            ).init();
            controller.setPluginConfig(variables.pluginConfig);
            controller.setConfigBean(variables.configBean);
            controller[actions[muraAction].method]();
        }
    }

}