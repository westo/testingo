<%inherit file="default.mako"/>
<%! import markupsafe%>
<%block name="title">${test.name}</%block>
<%block name="page_content">
    <!--[if lte IE 8]>
	<script src="${request.static_path('project:static/js/excanvas.js')}"></script>
    <![endif]-->
    <script src="${request.static_path('project:static/js/Chart.min.js')}"></script>
    <script src="${request.static_path('project:static/js/edit_points.js')}"></script>
    <script src="${request.static_path('project:static/js/create_comment.js')}"></script>
    <script src="${request.static_path('project:static/js/confirm_deletion.js')}"></script>
    <script src="${request.static_path('project:static/js/edit_question.js')}"></script>
    <script type="text/javascript">
        post_url="${request.route_path('showquestion', test_id=test.id,question_id=question.id)}"
    </script>
    <ol class="breadcrumb">
        <li><a href="${request.route_path('dashboard')}"><span class="glyphicon glyphicon-home"></span> </a></li>
        <li><a id="own_tests" href="${request.route_path('dashboard')}">Vaše testy</a></li>
        <li><a href="${request.route_path('showtest', test_id=test.id)}">Test ${test.name}</a></li>

        <li class="active">Otázka č.${question.number}</li>
    </ol>

    <div class="page-header">
				<h1>Otázka č.${question.number}</h1>
				%if question.test.share_token is None:
	                <form action="#" method="POST" class="pull-right">
	                    <button id="delete_question" type="submit" class="btn btn-danger btns">Zmazať otázku</button>
                         <input type="hidden" name="_delete" value="DELETE">
	                </form>

	                <!-- Button trigger modal -->

	                <a data-toggle="modal" href="#myModal" class="btn btn-primary pull-right btns">Upraviť otázku</a>
                <!-- Modal -->
                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title">Úprava otázky č.${question.number} </h4>
                            </div>
                            <div class="modal-body">
								<%include file="edit_question.mako"/>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Zavrieť</button>
                                <button type="button" class="btn btn-primary" id="save_changes" name="${question.qtype}">Uložiť</button>
                            </div>
                        </div><!-- /.modal-content -->
                    </div><!-- /.modal-dialog -->
                </div><!-- /.modal -->
		%endif
		</div>

        <div class="control-group">
            <h4>${question.text.replace('\n', markupsafe.Markup('<br> '))|n}
                <span class="badge float-left">
                max. ${h.pretty_points(question.points)}b
            </span>
            </h4>

            <div class="list-group">
				% if len(answers) is 0:
                        <span> Otázka neobsahuje žiadne možnosti</span>
				% else:
					% for answer in question.answers:
						% if answer.correct == 1:
							% if (question.qtype == "C"):
                                <span><p class="text-success"><input class="checkInputC" type="checkbox" value="" checked disabled="disabled">
							% elif (question.qtype == "R"):
                                <span><p class="text-success"><input class="radioR" type="radio" value="" checked disabled="disabled" >
							% endif
							${answer.text}
                            </p></span>
						% else:
							% if (question.qtype == "C"):
                                    <span><p class="text-danger"><input class="checkInputC" type="checkbox" value="" disabled="disabled">
									${answer.text}
                                    </p></span>
							% elif (question.qtype == "R"):
                                    <span><p><input class="radioR" type="radio" value="" disabled="disabled">
									${answer.text}
                                    </p></span>
							% endif

						% endif
					% endfor

					%if question.mandatory:
                            <em> * Otázku je povinné vyplniť</em>
					%else:
                            <em> * Otázku nie je povinné vyplniť</em>
					%endif
				% endif
            </div>
        </div>

		<button type="button" class="btn btn-default btn-sm" data-toggle="collapse" data-target="#test_stats">Zobraz štatistiky</button>

    <div id="test_stats" class="collapse out">
        <hr>
        <div id="chart_desc">
            <strong>Najpopulárnejšie odpovede respondentov</strong><br><br>
        </div>

        %if question.qtype == "S":
            <% chart_id = 0 %>
            <ul>
            % for sub_answer in graph_data:
                <br><li>
                <a type="button" data-toggle="collapse" data-target="#answer${chart_id}">Odpoveď č.${chart_id+1}, správna odpoveď: ${sub_answer['correct_ans'].text}</a>

                <div id="answer${chart_id}" class="collapse out">
                <% chart_id = chart_id +1 %>
                        <canvas  id="myChart${chart_id}" width="300" height="300"></canvas>

                    <script>
                        var pieData =${sub_answer['data']|n};
                        var myPie = new Chart(document.getElementById("myChart${chart_id}").getContext("2d")).Pie(pieData,{ labelFontColor: 'white',labelAlign: 'right',labelFontSize : '14'});
                    </script>
                </div>
                </li>
            % endfor
            </ul>
		%endif
    </div>

    <hr>

    <div class="answer_s">

        <h2>Vyplnené odpovede</h2>

		% if len(list_of_answers) is 0:
                <em>Test ešte nikto neriešil</em>
		% else:
			% for answered_q in list_of_answers:
                <div class="panel panel-default">
                    <div class="panel-heading">

                        <h3 class="panel-title" id="o${answered_q[0].id}"> ${answered_q[1][0]}
                            <a class="glyphicon glyphicon-pencil pull-right zbody" id="c${answered_q[0].id}" name="${answered_q[2]}" data-points="${h.pretty_points(answered_q[0].question.points)}b"> </a>
                <span class="badge pull-right" id="b${answered_q[0].id}">



                ${h.pretty_points(answered_q[2])}
                    /   ${h.pretty_points(answered_q[0].question.points)}b

                </span>

                        </h3></div>
                <div class="panel-body">
				%if answered_q[0].question.qtype =='R':
					%for answer in answered_q[0].question.answers:
						%if int(answered_q[1][1][0].text) == answer.id and answered_q[1][1][0].correct ==1 :

                                <span><p class="text-success"><input type="radio" disabled="disabled" checked="checked">
								${answer.text}</p></span>
						%elif int(answered_q[1][1][0].text) != answer.id and answered_q[1][1][0].correct ==1 :
                                <span><p><input type="radio" disabled="disabled" >
								${answer.text}</p></span>
						%elif int(answered_q[1][1][0].text) == answer.id and answered_q[1][1][0].correct ==0 :
                                <span> <p class="text-danger"><input type="radio" disabled="disabled" checked="checked">
								${answer.text}</p></span>
						%elif int(answered_q[1][1][0].text) != answer.id and answered_q[1][1][0].correct ==0 :
                                <span> <p><input type="radio" disabled="disabled">
								${answer.text}</p></span>
						%endif

					%endfor
				%elif answered_q[0].question.qtype =='C':
					%for answer in answered_q[1][1]:

						%if answer.text== str(1) and  answer.correct == int(1) :
                                <span><p class="text-success"><input type="checkbox" disabled="disabled" checked="checked">
								${answer.answer.text}</p></span>
						%elif answer.text==str(0) and  answer.correct == int(1) :
                                <span><p class="text-success"><input type="checkbox" disabled="disabled" >
								${answer.answer.text}</p></span>
						%elif answer.text==str(1) and  answer.correct ==int(0) :
                                <span> <p class="text-danger"><input type="checkbox" disabled="disabled" checked="checked">
								${answer.answer.text}</p></span>
						%elif answer.text==str(0) and  answer.correct ==int(0) :
                                <span> <p class="text-danger"><input type="checkbox" disabled="disabled">
								${answer.answer.text}</p></span>
						%endif

					%endfor

				%elif answered_q[0].question.qtype =='S':
					%for answer in answered_q[1][1]:
						%if answer.correct == int(1):
                                <p class="text-success">
                                    <strong>Správna odpoveď uźívateľa:</strong>
								${answer.text} <br>
                                </p>
						%elif answer.correct == int(0):
                                <p class="text-danger">
                                    <strong>Nesprávna odpoveď uźívateľa:</strong>
								${answer.text} <br>
                                </p>

						%endif

					%endfor

				%elif answered_q[0].question.qtype =='O':
					%for answer in answered_q[1][1]:
                            <p>
                                <strong>Odpoveď užívateľa:</strong>
							${answer.text} <br></p>
					%endfor
				%endif
                <div class="accordion" id="a${answered_q[0].id}">
                <div class="accordion-group">
                    <div class="accordion-heading">

                        <a class="accordion-toggle pull-right" data-toggle="collapse" data-parent="a${answered_q[0].id}" href="#h${answered_q[0].id}">
                            Komentár
                        </a>

                    </div>

                <div id="h${answered_q[0].id}" class="accordion-body collapse out">
                <div class="accordion-inner">

                    <a class="zkomment bezhref pull-right" id="upravit_btn${answered_q[0].id}" name="${answered_q[0].comment}"><br>Upraviť</a>
                <div id="koment_text${answered_q[0].id}">
                    <br>Komentár:<br>

				% if  answered_q[0].comment:
                        <div class="well well-sm" id="koment_text#{tu}">
						${answered_q[0].comment.replace('\n', markupsafe.Markup('<br> '))|n}
                        </div>
				% endif

                </div>

                    <div id="koment_area${answered_q[0].id}"></div>
                </div>
                </div>
                </div>
                </div>
                </div>
                </div>


			% endfor
		% endif
    </div>
</%block>
