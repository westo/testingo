<dl class="dl-horizontal">
                <!--<dt><strong>Najúspešnejší respondent(i):</strong></dt>
                <dd></dd>-->
                <dt><strong>Počet respondentov:</strong></dt>
                <dd>${no_of_respondents}</dd>
                <dt><strong>Priemerný bodový zisk:</strong></dt>

                % if test.sum_points is not 0:
                    <dd>${h.pretty_points(avg_pts)}b | ${h.pretty_points((avg_pts/test.sum_points)*100)}%</dd>
                % else:
                    <dd>žiaden</dd>
                % endif
</dl>