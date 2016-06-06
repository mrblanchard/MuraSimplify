component extends="Base" {

    public any function edit() {

        var datasource = this.configBean.getDatasource();

        var groupId = "";
        if (structKeyExists(url, "userId") && len(url.userId) > 0) {
            groupId = url.userId;
        } else if (structKeyExists(form, "userId") && len(form.userId) > 0) {
            groupId = form.userId;
        } else {
            request.muraSimplify.newUserGroup = true;
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

    public any function save() {
        if(!structKeyExists(form, "muraSimplifyData")
            || !structKeyExists(form.muraSimplifyData, "isUserGroup")) {
            return;
        }

        var datasource = this.configBean.getDatasource();
        var groupId = url.userId;

        var queryService = new Query();
        queryService.setDatasource(datasource);
        queryService.setSql("
            DELETE FROM
                mura_simplify_group_feature
            WHERE
                groupId = :groupId
        ");
        queryService.addParam(
            name = "groupId",
            value = groupId,
            cfSqlType = "cf_sql_char"
        );
        queryService.execute();

        queryService = new Query();
        queryService.setDatasource(datasource);
        queryService.setSql("
            INSERT INTO mura_simplify_group_feature (
                groupId,
                featureId
            ) VALUES (
                :groupId,
                :featureId
            )
        ");
        for (var featureId in form.muraSimplifyData.features) {
            queryService.clearParams();
            queryService.addParam(
                name = "groupId",
                value = groupId,
                cfSqlType = "cf_sql_char"
            );
            queryService.addParam(
                name = "featureId",
                value = featureId,
                cfSqlType = "cf_sql_integer"
            );
            queryService.execute();
        }
    }

};