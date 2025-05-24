# Notes on how Mocktail works

### Topic: Stubbing

Stubbing means controlling how your mock should do or should return.<br>
Mocktail uses two stub methods

- `When`
- `thenReturn`
  <br>

<p>Through this we are saying that this mock should return this specific value when 
this specific method is called.
</p>

<p>In your test.dart you need to create a mock version of the class you want to mock.</p>

```dart
class MockClass extends Mock implements RealClass {}
```
Next we put our tests in `void main()` method.

```dart
class MockClass extends Mock implements RealClass {}

void main() {
  // create an instance of the MockClass
  
  late MockClass mockClass;

  // setUp() to make sure these set of code runs every time before any test
  // here we initiate out MockClass
  
  setUp(() {
    mockClass = MockClass();
  });

  group('description or name of test group', () {
    test('description of what is the test for', () {
      
      // This part is called 'ARRANGE'
      // Here we set what our mock should return when a specific function gets called
      // Here the function we want to test is 'anyMethod'
      // we also have set what anyMethod should return,
      // in this case, it should return 'anyAnswer'
      
      when(() => mockClass.anyMethod()).thenReturn(anyAnswer);
      
      // This part is called 'ACT'
      // Here we execute the actual code we are testing
      // and store the result in a variable
      
      final result = mockClass.anyMethod();
      
      // This part is called 'ASSERT'
      
      expect(result, equals(anyAnser));
    });
  });
}
```
