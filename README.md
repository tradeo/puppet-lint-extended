# puppet-lint-extended
Provides additional checks for [puppet-lint](https://github.com/rodjek/puppet-lint) that are not part of the puppet style guide but still make for good  code.

## List of the checks:

### leading_comment_space
```
 # bad
 #comment

 # good
 # comment

 # allows
 ########
```


### space_after_comma
```
 # bad
 [foo,bar]

 # good
 [foo, bar]

 # allows
 [foo, bar,]
 foo,;
 ```
### space_around_operator
```
 # bad
 $foo='bar'
 if $baz<1

 # good
 $foo = 'bar'
 if $baz < 1
 ```

### space_inside_braces
```
 # bad
 {foo:'bar'}

 # good
 { foo:'bar' }

 # allows
 {}
 ```
