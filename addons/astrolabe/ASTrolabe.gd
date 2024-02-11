extends Object
class_name ASTrolabe

static func string_literal(str: String):
	return '"%s"' % [str]

static func comment(comment_text: String, depth: int=1):
	return "%s %s" % ["#".repeat(depth), comment_text]

static func invoke(function: String, params: Array[String]=[]):
	var params_str = ""
	if len(params) > 0:
		params_str = '%s' % params[0]
		params.pop_front()
		for param in params:
			params_str += ', %s' % param
	return "%s(%s)" % [function, params_str]

static func bracket(contents):
	return "(%s)" % [contents]

static func binary_invoke(op: String, alpha: String, omega: String):
	return "%s %s %s" % [alpha, op, omega]

static func variable(var_name: String, expr: String, type: String="",  constant: bool=false):
	var type_suffix = " " if type == "" else ": %s " % [type]
	return "%s %s%s= %s" % ["var" if not constant else "const", var_name, type_suffix, expr]

static func extend(_class: String):
	return "extends %s" % [_class]

static func define_block(lines: Array[String]):
	assert(len(lines) > 0, "Cannot have block with 0 lines")
	var lines_str = '%s' % lines[0]
	lines.pop_front()
	for line in lines:
		lines_str += '\n%s' % line
	return lines_str

static func return_stmt(val: String):
	return "return %s" % [val]

static func define_function(name: String, params: Array[String], body: String, _static: bool=false):
	var params_str = ""
	if len(params) > 0:
		params_str = '%s' % params[0]
		params.pop_front()
		for param in params:
			params_str += ', %s' % param
	var prefix = "static func" if _static else "func"
	return "%s %s(%s):\n%s" % [prefix, name, params_str, body.indent("\t")]
