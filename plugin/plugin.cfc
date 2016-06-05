component accessors=true extends='mura.plugin.plugincfc' output=false {

    public void function install() {

        var datasource = this.getConfigBean().getDatasource();

        // Create the feature table
        var queryService = new Query();
        queryService.setDatasource(datasource);
        queryService.setSql("
            CREATE TABLE mura_simplify_feature (
                featureId int(4) NOT NULL AUTO_INCREMENT,
                code varchar(255) NOT NULL,
                label varchar(255) NOT NULL,
                parentId int(4) NOT NULL,
                orderNo int(4) NOT NULL,
                required int(1) NOT NULL,
                PRIMARY KEY (featureId),
                KEY parentId (parentId),
                KEY orderNo (orderNo)
            );
        ");
        queryService.execute();

        // Create the group_feature table
        var queryService = new Query();
        queryService.setDatasource(datasource);
        queryService.setSql("
            CREATE TABLE mura_simplify_group_feature (
              groupId char(35) NOT NULL,
              featureId int(4) NOT NULL,
              PRIMARY KEY (groupId,featureId)
            );
        ");
        queryService.execute();

        // Insert the supported features
        var features = [{
            featureId: 1,
            code: "TOP_MENU",
            label: "Top Menu",
            parentId: 0,
            required: true
        }, {
            featureId: 2,
            code: "TOP_MENU_VERSION",
            label: "Version",
            parentId: 1
        }, {
            featureId: 3,
            code: "TOP_MENU_VERSION_CORE_VERSION",
            label: "Core Version",
            parentId: 2
        }, {
            featureId: 4,
            code: "TOP_MENU_VERSION_SITE_VERSION",
            label: "Site Version",
            parentId: 2
        }, {
            featureId: 5,
            code: "TOP_MENU_VERSION_APP_SERVER",
            label: "App Server",
            parentId: 2
        }, {
            featureId: 6,
            code: "TOP_MENU_VERSION_DB_SERVER",
            label: "DB Server",
            parentId: 2
        }, {
            featureId: 7,
            code: "TOP_MENU_VERSION_JAVA_VERSION",
            label: "Java Version",
            parentId: 2
        }, {
            featureId: 8,
            code: "TOP_MENU_VERSION_OS_VERSION",
            label: "OS Version",
            parentId: 2
        }, {
            featureId: 9,
            code: "TOP_MENU_SETTINGS",
            label: "Settings",
            parentId: 1
        }, {
            featureId: 10,
            code: "TOP_MENU_SETTINGS_GLOBAL_SETTINGS",
            label: "Global Settings",
            parentId: 9
        }, {
            featureId: 11,
            code: "TOP_MENU_SETTINGS_PLUGINS",
            label: "Plugins",
            parentId: 9
        }, {
            featureId: 12,
            code: "TOP_MENU_SETTINGS_ADD_SITE",
            label: "Add Site",
            parentId: 9
        }, {
            featureId: 13,
            code: "TOP_MENU_SETTINGS_SITE_COPY",
            label: "Site Copy",
            parentId: 9
        }, {
            featureId: 14,
            code: "TOP_MENU_SETTINGS_RELOAD_APPLICATION",
            label: "Reload Application",
            parentId: 9
        }, {
            featureId: 15,
            code: "TOP_MENU_SETTINGS_UPDATE_MURA_CORE",
            label: "Update Mura Core",
            parentId: 9
        }, {
            featureId: 16,
            code: "TOP_MENU_HELP",
            label: "Help",
            parentId: 1
        }, {
            featureId: 17,
            code: "TOP_MENU_HELP_DOCUMENTATION",
            label: "Documentation",
            parentId: 16
        }, {
            featureId: 18,
            code: "TOP_MENU_HELP_EDITOR_FILE_MANAGER_DOCS",
            label: "Editor/File Manager Docs",
            parentId: 16
        }, {
            featureId: 19,
            code: "TOP_MENU_HELP_COMPONENT_API",
            label: "Component API",
            parentId: 16
        }, {
            featureId: 20,
            code: "TOP_MENU_HELP_PROFESSIONAL_SUPPORT",
            label: "Professional Support",
            parentId: 16
        }, {
            featureId: 21,
            code: "TOP_MENU_HELP_COMMUNITY_SUPPORT",
            label: "Community Support",
            parentId: 16
        }, {
            featureId: 22,
            code: "TOP_MENU_USER",
            label: "User",
            parentId: 1,
            required: true
        }, {
            featureId: 23,
            code: "TOP_MENU_USER_EDIT_PROFILE",
            label: "Edit Profile",
            parentId: 22
        }, {
            featureId: 24,
            code: "TOP_MENU_USER_LOGOUT",
            label: "Logout",
            parentId: 22,
            required: true
        }, {
            featureId: 25,
            code: "MAIN_MENU",
            label: "Main Menu",
            parentId: 0
        }, {
            featureId: 26,
            code: "MAIN_MENU_CURRENT_SITE",
            label: "Current Site",
            parentId: 25
        }, {
            featureId: 27,
            code: "MAIN_MENU_CURRENT_SITE_TOGGLE_SITE",
            label: "Toggle Site",
            parentId: 26
        }, {
            featureId: 28,
            code: "MAIN_MENU_DASHBOARD",
            label: "Dashboard",
            parentId: 25
        }, {
            featureId: 29,
            code: "MAIN_MENU_SITE_MANAGER",
            label: "Site Manager",
            parentId: 25
        }, {
            featureId: 30,
            code: "MAIN_MENU_MODULES",
            label: "Modules",
            parentId: 25
        }, {
            featureId: 31,
            code: "MAIN_MENU_MODULES_CONTENT_STAGING",
            label: "Content Staging",
            parentId: 30
        }, {
            featureId: 32,
            code: "MAIN_MENU_MODULES_COMMENTS",
            label: "Comments",
            parentId: 30
        }, {
            featureId: 33,
            code: "MAIN_MENU_MODULES_COMPONENTS",
            label: "Components",
            parentId: 30
        }, {
            featureId: 34,
            code: "MAIN_MENU_MODULES_CATEGORIES",
            label: "Categories",
            parentId: 30
        }, {
            featureId: 35,
            code: "MAIN_MENU_MODULES_CONTENT_COLLECTIONS",
            label: "Content Collections",
            parentId: 30
        }, {
            featureId: 36,
            code: "MAIN_MENU_MODULES_FORMS",
            label: "Forms",
            parentId: 30
        }, {
            featureId: 37,
            code: "MAIN_MENU_MODULES_FILE_MANAGER",
            label: "File Manager",
            parentId: 30
        }, {
            featureId: 38,
            code: "MAIN_MENU_MODULES_PLUGINS",
            label: "Plugins",
            parentId: 30
        }, {
            featureId: 39,
            code: "MAIN_MENU_MODULES_PLUGINS_ADD_PLUGIN",
            label: "Add Plugin",
            parentId: 38
        }, {
            featureId: 40,
            code: "MAIN_MENU_USERS",
            label: "Users",
            parentId: 25
        }, {
            featureId: 41,
            code: "MAIN_MENU_USERS_VIEW_GROUPS",
            label: "View Groups",
            parentId: 40
        }, {
            featureId: 42,
            code: "MAIN_MENU_USERS_VIEW_USERS",
            label: "View Users",
            parentId: 40
        }, {
            featureId: 43,
            code: "MAIN_MENU_USERS_ADD_GROUP",
            label: "Add Group",
            parentId: 40
        }, {
            featureId: 44,
            code: "MAIN_MENU_USERS_ADD_USER",
            label: "Add User",
            parentId: 40
        }, {
            featureId: 45,
            code: "MAIN_MENU_SITE_CONFIG",
            label: "Site Config",
            parentId: 25
        }, {
            featureId: 46,
            code: "MAIN_MENU_SITE_CONFIG_EDIT_SITE",
            label: "Edit Site",
            parentId: 45
        }, {
            featureId: 47,
            code: "MAIN_MENU_SITE_CONFIG_PERMISSIONS",
            label: "Permissions",
            parentId: 45
        }, {
            featureId: 48,
            code: "MAIN_MENU_SITE_CONFIG_APPROVAL_CHAIN",
            label: "Approval Chain",
            parentId: 45
        }, {
            featureId: 49,
            code: "MAIN_MENU_SITE_CONFIG_CLASS_EXTENSION_MANAGER",
            label: "Class Extension Manager",
            parentId: 45
        }, {
            featureId: 50,
            code: "MAIN_MENU_SITE_CONFIG_CLASS_EXTENSION_MANAGER_ADD",
            label: "Add Class Extension",
            parentId: 49
        }, {
            featureId: 51,
            code: "MAIN_MENU_SITE_CONFIG_CLASS_EXTENSION_MANAGER_IMPORT",
            label: "Import Class Extension",
            parentId: 49
        }, {
            featureId: 52,
            code: "MAIN_MENU_SITE_CONFIG_CLASS_EXTENSION_MANAGER_EXPORT",
            label: "Export Class Extension",
            parentId: 49
        }, {
            featureId: 53,
            code: "MAIN_MENU_SITE_CONFIG_CREATE_SITE_BUNDLE",
            label: "Create Site Bundle",
            parentId: 45
        }, {
            featureId: 54,
            code: "MAIN_MENU_SITE_CONFIG_DEPLOY_SITE_BUNDLE",
            label: "Deploy Site Bundle",
            parentId: 45
        }, {
            featureId: 55,
            code: "MAIN_MENU_SITE_CONFIG_TRASH_BIN",
            label: "Trash Bin",
            parentId: 45
        }, {
            featureId: 56,
            code: "MAIN_MENU_SITE_CONFIG_UPDATE_SITE",
            label: "Update Site",
            parentId: 45
        }];
        queryService = new Query();
        queryService.setDatasource(datasource);
        queryService.setSql("
            INSERT INTO mura_simplify_feature (
                featureId,
                code,
                label,
                parentId,
                orderNo,
                required
            ) VALUES (
                :featureId,
                :code,
                :label,
                :parentId,
                :orderNo,
                :required
            )
        ");
        var featureCount = arrayLen(features);
        var index = 1;
        for (index = 1; index <= featureCount; index++) {
            queryService.clearParams();
            queryService.addParam(
                name = "featureId",
                value = features[index].featureId,
                cfSqlType = "cf_sql_integer"
            );
            queryService.addParam(
                name = "code",
                value = features[index].code,
                cfSqlType = "cf_sql_varchar"
            );
            queryService.addParam(
                name = "label",
                value = features[index].label,
                cfSqlType = "cf_sql_varchar"
            );
            queryService.addParam(
                name = "parentId",
                value = features[index].parentId,
                cfSqlType = "cf_sql_integer"
            );
            queryService.addParam(
                name = "orderNo",
                value = index,
                cfSqlType = "cf_sql_integer"
            );
            queryService.addParam(
                name = "required",
                value = structKeyExists(features[index], "required") ? 1 : 0,
                cfSqlType = "cf_sql_integer"
            );
            queryService.execute();
        }

        // Enable all features for the current groups
        queryService = new Query();
        queryService.setDatasource(datasource);
        queryService.setSql("
            SELECT
                userId AS groupId
            FROM
                tusers
            WHERE
                groupName IS NOT NULL
        ");
        qGroups = queryService.execute().getResult();
        var inserts = [];
        for (var groupRow in qGroups) {
            for (index = 1; index <= featureCount; index++) {
                arrayAppend(inserts, "('#groupRow.groupId#', #index#)");
            }
        }
        queryService = new Query();
        queryService.setDatasource(datasource);
        queryService.setSql("
            INSERT INTO mura_simplify_group_feature (
                groupId,
                featureId
            ) VALUES #arrayToList(inserts)#
        ");
        queryService.execute();
    }

    public void function delete() {

        var datasource = this.getConfigBean().getDatasource();

        // Drop the feature table
        var queryService = new Query();
        queryService.setDatasource(datasource);
        queryService.setSql("
            DROP TABLE mura_simplify_feature
        ");
        queryService.execute();

        // Drop the group_feature table
        queryService = new Query();
        queryService.setDatasource(datasource);
        queryService.setSql("
            DROP TABLE mura_simplify_group_feature
        ");
        queryService.execute();
    }

}