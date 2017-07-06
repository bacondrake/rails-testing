# An introduction to Rails Testing

I ran through the [CodeSchool](www.codeschool.com) Rails Testing course and have uploaded the levels to this repo so I can reference the information later. It contains copies of the same basic rails applications for each level.

All relevant information is basically in the ```test/``` folder.

## Basic level breakdown

* Level 1 - Introductions
* Level 2 - Model tests
* Level 3 - Refactoring and the 'shoulda' gem
* Level 4 - Mocks and stubs

### Mocks and stubs

*Mocks* will mock up returns with specific information so we can test to see whether a method is called in a test (i.e. you can 'expect' a method to be called). Usually looks like this:

```
test "blah" do
  Model.expects(model_method)         # expects the model_method to be called during this test
  Model.method_that_uses_model_method # #method_that_uses_model_method will call on model_method, so the #expects method on the line above asserts that #model_method is called during the test, otherwise it'll fail
end
```

*Stubs* will take the code in a method and have it simply return nil. This is used if you're not actually testing the code in that method, rather you're testing an outcome of that method being called. For example:

```
IN THE MODELS:
def a_method(*args)
  # lots of complex and probably changing code lives here
end

.
.
.

# Use a_method to change the status of a class instance
def status_changing_method
  other_model.a_method(self)
  self.status = "status changed"
end

IN THE TEST:
test "a_method should used to make a status change" do
  @class_instance.stubs(:a_method) # We're not checking that all the code in a_method does its stuff, rather we're checking that the status_changing_method changes the status after using a_method
  @class_instance.status_changing_method
  assert "status changed", @class_instance.status
end
```