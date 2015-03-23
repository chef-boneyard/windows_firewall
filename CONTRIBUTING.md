## Functional and Unit Tests

This cookbook is set up to run tests using test-kitchen. It uses serverspec to run integration tests after the node has been converged to verify that the state of the node.

Test kitchen should run completely without exception using the default baseboxes provided in the existing .kitchen.yml. Because Test Kitchen creates VirtualBox machines and runs through every configuration in the Kitchenfile, it may take some time for these tests to complete.

If your changes are only for a specific recipe, run only its configuration with Test Kitchen. If you are adding a new recipe, or other functionality such as a LWRP or definition, please add appropriate tests and ensure they run with Test Kitchen.

If any don't pass, investigate them before submitting your patch.

Any new feature should have unit tests included with the patch with good code coverage to help protect it from future changes. Similarly, patches that fix a bug or regression should have a regression test. Simply put, this is a test that would fail without your patch but passes with it. The goal is to ensure this bug doesn't regress in the future. Consider a regular expression that doesn't match a certain pattern that it should, so you provide a patch and a test to ensure that the part of the code that uses this regular expression works as expected. Later another contributor may modify this regular expression in a way that breaks your use cases. The test you wrote will fail, signalling to them to research your ticket and use case and accounting for it.

If you need help writing tests, please ask on the Chef Developer's mailing list, or the #chef IRC channel.

#### Note about Test-Kitchen with Windows guests

Until the Windows guest support is fully merged in, in order to execute kitchen tests on this cookbook you will first need to execute *bundle install* from within the cookbook directory, to install required gems. All kitchen commands will also need to be prefaced with *bundle exec*, i.e., "bundle exec kitchen test"