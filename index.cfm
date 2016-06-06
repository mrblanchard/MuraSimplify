<cfoutput>
    <cfset body = "" />
    <cfset githubUrl =
        "https://github.com/david-conde/MuraSimplify/releases" />
    <cfsavecontent variable="body">
        <div>
            <div id="contentBody">
                <h1>Mura Simplify</h1>
                <p>
                    Mura Simplify is a plugin for Mura CMS that enables you to
                    simplify the user experience of the administration area for
                    different user roles. It can enable or disable a wide
                    variety of features of the administration area, including
                    the main navigation, site manager columns, content tabs and
                    content attributes.
                </p>

                <h2>Minimum Requirements</h2>
                <ul>
                    <li>Mura CMS 6+</li>
                    <li>Chrome, Firefox, Internet Explorer 9+ or Safari</li>
                </ul>

                <h2>Important notice</h2>
                <p>
                    Mura Simplify is not a security plugin or permission
                    system. It simply tries to make the administration area
                    easier to use for authorized users. It provides this
                    simplification through the use of CSS and Javascript.
                </p>

                <h2>Installation</h2>
                <p>
                    Download the
                    <a href="#githubUrl#">latest stable release</a> to your
                    computer. Login to your Mura CMS administration area and
                    use the main navigation to navigate to
                    <strong>Settings / Plugins</strong>. Under "Install Plugin"
                    select "Upload file" and select the downloaded release.
                    Click "Deploy to start the installation". After accepting
                    the terms of the license you will be brought to the setup
                    page where you can choose which sites to enable the plugin
                    for and finalize the installation.
                </p>

                <h2>Basic Usage</h2>
                <p>
                    Use the main navigation to navigate to
                    <strong>Users / View System Groups</strong>. For any system
                    group except the "Admin" group select the edit icon or add
                    a new system group. On the next page select the tab
                    "Mura Simplify" and start customizing the user experience
                    for this group. Any user of this group who logs into the
                    administration area will now only see the enabled features.
                </p>

                <h2>License</h2>
                <p>
                    The MIT License (MIT)<br>
                    <br>
                    Copyright (c) 2016 David Conde<br>
                    <br>
                    Permission is hereby granted, free of charge, to any person
                    obtaining a copy of this software and associated
                    documentation files (the "Software"), to deal in the
                    Software without restriction, including without limitation
                    the rights to use, copy, modify, merge, publish,
                    distribute, sublicense, and/or sell copies of the Software,
                    and to permit persons to whom the Software is furnished to
                    do so, subject to the following conditions:<br>
                    <br>
                    The above copyright notice and this permission notice shall
                    be included in all copies or substantial portions of the
                    Software.<br>
                    <br>
                    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
                    KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
                    WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
                    PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
                    OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
                    OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
                    OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
                    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
                </p>
            </div>
        </div>
    </cfsavecontent>
    #request.muraSimplify.$.getBean('pluginManager').renderAdminTemplate(
        body = body)#
</cfoutput>