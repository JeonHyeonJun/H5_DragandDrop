var s = $.extend({
	data : [ [ '' ] ], // 데이터는 빈값
	tableClass : 'inputtable', // 테이블 클래스 지정
	jsonData : false, // jsondate 쓸건지
	headerCols : false, // 수정 열 번호 및 이름 (배열 의 열 이름)
	maxRows : 999, // 최대 수 의 첨가 될 수있는 행
	first_row : true, // 첫 번째 행이 강조되어야 하는가?
	row_template : false, // 배열 의 설정 항목 유형 에 field_templates
	field_templates : false, // 배열 중을 사용자 정의 필드 유형 객체

	// 유효성 검사 필드
	validate_field : function(col_id, value, col_type, $element) {
		return true;
	}
}, 0);

function complete(){
	 $(".inputtable").resizable('destroy');
	 $(".hi2td").resizable('destroy');
}

function addcol() {

	$('.addcol')
			.off("click")
			.on(
					'click',
					function() {
						var colid = parseInt($(this).closest('tr').children()
								.index($(this).parent('th')), 10);
						$table = $(this).closest("table");
						colnumber = $table.find('thead th').length - 1;
						rownumber = $table.find('tbody tr').length;
						defaultth = '<th><a class="addcol icon-button" href="#">+</a> <a class="delcol icon-button" href="#">-</a></th>';
						colnumber += 1;

						$table.find('thead tr').find('th:eq(' + colid + ')')
								.after(defaultth);

						$table.find('tbody tr').each(
								function() {
									$(this).find('td:eq(' + colid + ')').after(
											buildCell());
								});

						$table.find('.delcol').removeClass('disabled');

						$(function() {
							$(".hi2td").resizable();
						});
						addcol();
						return false;
					});

	$('.delcol').off("click").on(
			'click',
			function() {
				$table = $(this).closest("table");
				colnumber = $table.find('thead th').length - 1;
				rownumber = $table.find('tbody tr').length;
				if ($(this).hasClass('disabled')) {
					return false;
				}

				var colid = parseInt($(this).closest('tr').children().index(
						$(this).parent('th')), 10);

				colnumber -= 1;

				checkButtons(); // 라인수 체크 함수

				$(this).parent('th').remove();

				$table.find('tbody tr').each(function() {
					$(this).find('td:eq(' + colid + ')').remove();
				});

				return false;
			});
}

function addrow() {
	$('.addrow').off("click").on('click', function() {

		$table = $(this).closest("table");
		colnumber = $table.find('thead th').length - 1;
		rownumber = $table.find('tbody tr').length;

		if ($(this).hasClass('disabled')) {
			return false;
		}

		rownumber += 1;

		$(this).closest('tr').after(buildRow(0, colnumber));

		$table.find('.delrow').removeClass('disabled');

		checkButtons(); // 라인수 체크 함수

		$(function() {
			$(".hi2td").resizable();
		});
		addrow();
		return false;
	});

	$('.delrow').off("click").on('click', function() {
		$table = $(this).closest("table");
		colnumber = $table.find('thead th').length - 1;
		rownumber = $table.find('tbody tr').length;

		if ($(this).hasClass('disabled')) {
			return false;
		}

		rownumber -= 1;

		checkButtons(); // 라인수 체크 함수

		$(this).closest('tr').remove();

		$table.find('.addrow').removeClass('disabled');

		return false;
	});
}

function buildCell(content, type) {
	content = (content === 0) ? "0" : (content || '');
	// Custom type
	if (type && 'text' !== type) {
		var field = s.field_templates[type];
		return '<td>' + field.setValue(field.html, content)[0].outerHTML
				+ '</td>';
	}
	// Default
	return '<td class="hi2td"><input type="text" value="'
			+ content.toString().replace(/"/g, "&quot;") + '" /></td>';

	$(function() {
		$(".hi2td").resizable();
	});
} // end build cell

function buildRow(data, len) {

	var rowcontent = '', b;

	data = data || '';

	if (!s.row_template) {
		// Without row template
		for (b = 0; b < (len || data.length); b += 1) {
			rowcontent += buildCell(data[b]);
		}
	} else {
		// With row template
		for (b = 0; b < s.row_template.length; b += 1) {
			// For each field in the row
			rowcontent += buildCell(data[b], s.row_template[b]);
		}
	}

	return $(
			'<tr/>',
			{
				html : rowcontent
						+ '<td class="addrowtd"><a class="addrow icon-button" href="#">+</a> <a class="delrow icon-button" href="#">-</a></td>' // tr마지막에
																																				// 삭제
																																				// 추가
																																				// 버튼에
																																				// 대한
																																				// td를
																																				// 추가해준다.
																																				// href로
																																				// 번호를
																																				// 받아옴
			});

}

function checkButtons() {
	if (colnumber < 2) {
		$table.find('.delcol').addClass('disabled');
	}
	if (rownumber < 2) {
		$table.find('.delrow').addClass('disabled');
	}
	if (s.maxRows && rownumber === s.maxRows) {
		$table.find('.addrow').addClass('disabled');
	}

}

function exportData() {
	var row = 0, data = [], value;

	$table = $('.addcol').closest("table");
	is_validated = true;

	$table
			.find('tbody tr')
			.each(
					function() {

						row += 1;
						data[row] = [];

						$(this)
								.find('td:not(:last-child)')
								.each(
										function(i, v) {
											if (s.row_template
													&& 'text' !== s.row_template[i]) {
												var field = s.field_templates[s.row_template[i]], el = $(
														this).find(
														$(field.html).prop(
																'tagName'));

												value = field.getValue(el);
												if (!s.validate_field(i, value,
														s.row_template[i], el)) {
													is_validated = false;
												}
												data[row].push(value);
											} else {
												value = $(this).find(
														'input[type="text"]')
														.val();
												if (!s.validate_field(i, value,
														'text', v)) {
													is_validated = false;
												}
												data[row].push(value);
											}
										});

					});

	// Remove undefined
	data.splice(0, 1);

	return data;
}