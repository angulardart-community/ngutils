import 'dart:html';

class MetaService {
  bool _isSelector(String input) {
    return input.contains(RegExp(r'="(\w+)"'));
  }

  /// Retrieves the `meta` tag with the given tag attribute and value. If
  /// multiple tags with the same attribute and value, the last one will be
  /// returned.
  ///
  /// [attrSelector] must be in the form of `'tag_attribute="value"'`.
  MetaElement getTag(String attrSelector) {
    if (attrSelector == null) return null;
    return getTags(attrSelector)[0];
  }

  /// Retrieves a list of `<meta>` tags.
  ///
  /// [attrSelector] must be in the form of `'tag_attribute="value"'`.
  List<MetaElement> getTags(String attrSelector) {
    if (attrSelector == null) return null;

    if (_isSelector(attrSelector)) {
      print('Is a normal selector!'); // TODO: remove when publishing
      return document.head.querySelectorAll('meta[$attrSelector]');
    } else {
      // Since to my knowledge, `og:` is the only popular meta tag that uses
      // "property" instead of "name" as attribute name, we check for the
      // tags with the "property" attribute first for a more efficient search.
      if (attrSelector.startsWith('og:')) {
        return document.head.querySelectorAll('meta[property=$attrSelector]') ??
            document.head.querySelectorAll('meta[name=$attrSelector]');
      } else {
        return document.head.querySelectorAll('meta[name=$attrSelector]') ??
            document.head.querySelectorAll('meta[property=$attrSelector]');
      }
    }
  }

  /// Adds and retrieves a specific `<meta>` tag in the current HTML document.
  ///
  /// If [forceCreation] is set to `true`, creates a flag without checking if it
  /// exists and replaces it if it does. Defaults to `false`.
  ///
  /// Unlike all other methods in [MetaService], [attrSelector] **MUST** be in
  /// the form `tag_attribute="value"`.
  ///
  /// ```dart
  /// addTag('name="description"', 'My fantastic website.');
  /// addTag('description', 'My fantastic website.'); // Throws error
  /// ```
  MetaElement addTag(String attrSelector, String content,
      {bool forceCreation = false}) {
    try {
      assert(_isSelector(attrSelector));
    } catch (e) {
      throw Exception(
          '`attrSelector` must be in the form of `tag_attribute="value"` when using `MetaService.addTag()`.');
    }

    if (!forceCreation) {
      try {
        assert(getTags(attrSelector).isEmpty);
      } catch (e) {
        throw Exception(
            'Tag $attrSelector already exists! To replace it, set `forceCreation` to `true` or use `MetaService.setTag`.');
      }
    }

    final dividerIdx = attrSelector.indexOf('=');

    var meta = Element.tag('meta')
      ..attributes = {
        attrSelector.substring(0, dividerIdx):
            attrSelector.substring(dividerIdx + 2, attrSelector.length - 1),
        'content': content,
      };
    print(meta.attributes); // TODO: remove when publishing
    document.head.append(meta);
    return meta;
  }

  /// Modify an existing `<meta>` tag element in the current HTML document.
  ///
  /// [attrSelector] may be in the form of `"tag_attribute=value"`, otherwise 
	/// finds a tag with the same `name` or `property` attribute value as the
  /// replacement tag.
  ///
  /// ```dart
  /// setTag('description', 'My fantastic website.');
  /// setTag('og:description', 'My fantastic website.');
  /// setTag('name="description"', 'My fantastic website.');
  /// ```
  MetaElement setTag(String attrSelector, String content) {
    getTag(attrSelector).content = content;
    return getTag(attrSelector);
  }

  /// Remove an existing `<meta>` tag element in the current HTML document.
  ///
  /// [attrSelector] may be in the form of `"tag_attribute=value"`, otherwise
  /// removes the tag with the same `name` or `property` attribute value
  /// specified.
  ///
  /// ```dart
  /// removeTag('description');
  /// removeTag('name="description"');
  /// ```
  void removeTag(String attrSelector) {
    getTag(attrSelector).remove();
  }

  /// Remove list of `<meta>` tag elements in the current HTML document.
  ///
  /// Each selector may be in the form of `"tag_attribute=value"`, otherwise
  /// removes the tag with the same `name` or `property` attribute value
  /// specified.
  ///
  /// ```dart
  /// removeTag('description');
  /// removeTag('name="description"');
  /// ```
  void removeTags(List<String> attrSelectors) {
    for (var attrSelector in attrSelectors) {
      removeTag(attrSelector);
    }
  }
}
