extends GutTest

var expr = Expression.new()

func test_comment():
	var comment_depth_1 = ASTrolabe.comment("test comment")
	var comment_depth_10 = ASTrolabe.comment("test comment", 10)
	assert_eq(comment_depth_1, "# test comment", "Should generate correct comment depth")
	assert_eq(comment_depth_10, "########## test comment", "Should generate correct comment depth for larger depths")

func test_invoke():
	var do_print = ASTrolabe.invoke("print", ['"test"'])
	var do_print_multiple_params = ASTrolabe.invoke("print", ['"test"', '"test 2"', '"test 3"'])
	var do_print_no_params = ASTrolabe.invoke("print")
	assert_eq(do_print, 'print("test")', "Should generate correct function invocation")
	assert_eq(do_print_multiple_params, 'print("test", "test 2", "test 3")', "Should generate correct function invocation with multiple params")
	assert_eq(do_print_no_params, 'print()', "Should generate correct function invocation with no params")

func test_variable():
	var do_variable = ASTrolabe.variable("new_var", "1 + 1")
	var do_typed_variable = ASTrolabe.variable("new_var", "1 + 1", "float")
	var do_const = ASTrolabe.variable("new_var", "1 + 1", "", true)
	assert_eq(do_variable, 'var new_var = 1 + 1', "Should generate correct variable definition")
	assert_eq(do_typed_variable, 'var new_var: float = 1 + 1', "Should generate correct typed variable definition")
	assert_eq(do_const, 'const new_var = 1 + 1', "Should generate correct constant definition")

func test_function_definition():
	var adder = ASTrolabe.define_function("adder",\
											["a", "b"],\
											ASTrolabe.define_block([ASTrolabe.variable("result", "a + b"),\
																	ASTrolabe.return_stmt("result")]))
	adder = adder.split("\n")
	assert_eq(len(adder), 3, "Should return a three line function when defining a function with a variable and a return")

func test_expression_sequence():
	var expression = ASTrolabe.binary_invoke("*", "2", ASTrolabe.bracket(ASTrolabe.binary_invoke("+", "3", "4")))
	expr.parse(expression)
	var res = expr.execute()
	print(expression)
	assert_eq(res, 14, "Should return 10 when constructing 2 * (3 + 4)")
