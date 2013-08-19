<%inherit file="default.mako" />
<%block name="title">Nová otázka - fráza</%block>
<%block name="page_content">

    <script src="${request.static_path('project:static/js/question_o.js')}"></script>
    <script type="text/javascript">
        post_url="${request.route_path('newquestion_o', test_id=test.id)}"
        test_url="${request.route_path('showtest', test_id=test.id)}"
    </script>

    <div class="page-header">
        <h1>Nová otázka (otvorená) do testu <a href="${request.route_path('showtest',test_id=test.id)}">${test.name}</a></h1>
    </div>

    <div class="container" id="newq">
        <form action="#" id="form_o">
            <div class="form-group">
                <label for="text">Znenie otázky</label>
                <textarea class="form-control" name="text" id="text" rows="3" placeholder="Znenie otázky" required></textarea>
            </div>

            <div class="form-group">
                <label for="points">Body</label>
                <input id="points" name="points" class="form-control" placeholder="Body">
            </div>

            <div id="answer_o">
                <label for="odpoved">Správna odpoveď</label>
                <textarea type="text" id="s#{ix}" name="odpoved" class="phrase form-control" placeholder="Odpoveď myslím, že vyplniť pre vlastnú potrebu snáď môžete..."></textarea>
            </div>

            <div class="form-group btn-group pull-left">
                <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                    <span class="glyphicon glyphicon-ok"></span> Uložiť a pridať ďalšiu <span class="caret"></span>
                </button>
                <ul class="dropdown-menu">
                    <li><a href="" id="save_and_add_s">Fráza</a></li>
                    <li><a href="" id="save_and_add_c">Checkbox</a></li>
                    <li><a href="" id="save_and_add_r">Rádio</a></li>
                    <li><a href="" id="save_and_add_o">Otvorená</a></li>
                </ul>
            </div>
            <button type="submit" formaction="#" class="btn btn-default" id="save_and_end" style="margin-left: 5px;">Uložiť a skončiť</button>

            <div class="pull-right"><a href="${request.route_path('showtest', test_id=test.id)}" class="btn btn-danger">Zrušiť</a></div>
        </form>
    </div>

    <%include file="showquestions.mako"/>

</%block>