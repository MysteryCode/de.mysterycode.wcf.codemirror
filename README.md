de.mysterycode.wcf.codemirror || CodeMirror
====================================
Implementation of the code editor [CodeMirror](https://github.com/codemirror/CodeMirror).

API
---
In order to include the CodeMirror editor use:

`{include file='codemirror' codemirrorMode='language' codemirrorSelector='id of your textarea'}`

**Example:**
```
<section class="section marginTop">
    <legend>An awesome section-title</legend>
    
    <dl class="wide">
        <dt>Your message in here:</dt>
        <dd>
            <textarea id="scss" name="scss">/* some SCSS seclarations */</textarea>
            {include file='codemirror' codemirrorMode='text/x-less' codemirrorSelector='scss'}
        </dd>
    </dl>
</section>
```

Version
---
CodeMirror-Version: 5.62.3

Basic Support
-------------
If you have trouble including the CodeMirror editor or questions feel free to ask me: [Forum](https://support.mysterycode.de/)

If you got questions about CodeMirror itself, please visit their [GitHub Repository](https://github.com/codemirror/CodeMirror).

License
-------
CodeMirror is licensed under [MIT License](https://github.com/codemirror/CodeMirror/blob/master/LICENSE)
