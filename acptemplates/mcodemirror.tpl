{if !$codemirrorLoaded|isset}
	<script data-relocate="true">window.define.amd = undefined;</script>
	<script data-relocate="true" src="{@$__wcf->getPath()}js/3rdParty/codemirror-mc/codemirror.js"></script>
	<script data-relocate="true" src="{@$__wcf->getPath()}js/3rdParty/codemirror-mc/addon/dialog/dialog.js"></script>
	<script data-relocate="true" src="{@$__wcf->getPath()}js/3rdParty/codemirror-mc/addon/search/searchcursor.js"></script>
	<script data-relocate="true" src="{@$__wcf->getPath()}js/3rdParty/codemirror-mc/addon/search/search.js"></script>
	<script data-relocate="true">window.define.amd = window.__require_define_amd;</script>
	<script data-relocate="true">
		[
			'{@$__wcf->getPath()}js/3rdParty/codemirror-mc/codemirror.css',
			'{@$__wcf->getPath()}js/3rdParty/codemirror-mc/addon/dialog/dialog.css',
			'{@$__wcf->getPath()}js/3rdParty/codemirror-mc/addon/fold/foldgutter.css',
			'{@$__wcf->getPath()}js/3rdParty/codemirror-mc/theme/{CODEMIRROR_THEME}.css',
		].forEach((href) => {
			const link = document.createElement('link');
			link.rel = 'stylesheet';
			link.href = href;
			document.head.appendChild(link);
		});
	</script>
{/if}
{if $codemirrorMode|isset}
	<script data-relocate="true">window.define.amd = undefined;</script>
	{if $codemirrorMode != 'smartymixed'}
		<script data-relocate="true" src="{@$__wcf->getPath()}js/3rdParty/codemirror-mc/mode/{if $codemirrorMode == 'text/x-less'}css/css{else}{$codemirrorMode}/{$codemirrorMode}{/if}.js"></script>
	{/if}

	<script data-relocate="true" src="{@$__wcf->getPath()}js/3rdParty/codemirror-mc/addon/fold/foldcode.js"></script>
	<script data-relocate="true" src="{@$__wcf->getPath()}js/3rdParty/codemirror-mc/addon/fold/foldgutter.js"></script>
	<script data-relocate="true" src="{@$__wcf->getPath()}js/3rdParty/codemirror-mc/addon/fold/brace-fold.js"></script>
	<script data-relocate="true" src="{@$__wcf->getPath()}js/3rdParty/codemirror-mc/addon/fold/indent-fold.js"></script>
	<script data-relocate="true" src="{@$__wcf->getPath()}js/3rdParty/codemirror-mc/addon/fold/comment-fold.js"></script>

	{if $codemirrorMode == 'htmlmixed' || $codemirrorMode == 'smartymixed' || $codemirrorMode == 'php'}
		{if $codemirrorMode == 'smartymixed'}
			<script data-relocate="true" src="{@$__wcf->getPath()}js/3rdParty/codemirror-mc/mode/htmlmixed/htmlmixed.js"></script>
			<script data-relocate="true" src="{@$__wcf->getPath()}js/3rdParty/codemirror-mc/mode/smarty/smarty.js"></script>
		{elseif $codemirrorMode == 'php'}
			<script data-relocate="true" src="{@$__wcf->getPath()}js/3rdParty/codemirror-mc/mode/htmlmixed/htmlmixed.js"></script>
			<script data-relocate="true" src="{@$__wcf->getPath()}js/3rdParty/codemirror-mc/mode/clike/clike.js"></script>
		{/if}
		
		<script data-relocate="true" src="{@$__wcf->getPath()}js/3rdParty/codemirror-mc/mode/css/css.js"></script>
		<script data-relocate="true" src="{@$__wcf->getPath()}js/3rdParty/codemirror-mc/mode/javascript/javascript.js"></script>
		<script data-relocate="true" src="{@$__wcf->getPath()}js/3rdParty/codemirror-mc/mode/xml/xml.js"></script>
		<script data-relocate="true" src="{@$__wcf->getPath()}js/3rdParty/codemirror-mc/addon/fold/xml-fold.js"></script>
	{/if}
	{if $codemirrorMode === 'markdown'}
		<script data-relocate="true" src="{@$__wcf->getPath()}js/3rdParty/codemirror-mc/addon/fold/markdown-fold.js"></script>
	{/if}
	<script data-relocate="true">window.define.amd = window.__require_define_amd;</script>
	{assign var='codemirrorLoaded' value=true}
{/if}
{event name='javascriptIncludes'}

<script data-relocate="true">
	require(['EventHandler', 'Dom/Traverse', 'Dom/Util'], function(EventHandler, DomTraverse, DomUtil) {
		const elements = document.querySelectorAll('{@$codemirrorSelector|encodeJS}');
		const config = {
			{if $codemirrorMode|isset}
				{if $codemirrorMode == 'smartymixed'}
				mode: {
					name: 'smarty',
					baseMode: 'text/html',
					version: 3
				},
				{else}
				mode: '{@$codemirrorMode|encodeJS}',
				{/if}
			{/if}
			lineWrapping: true,
			indentWithTabs: true,
			lineNumbers: true,
			indentUnit: 4,
			readOnly: {if !$editable|isset || $editable}false{else}true{/if},
			theme: '{CODEMIRROR_THEME}',
			foldGutter: true,
			gutters: ["CodeMirror-linenumbers", "CodeMirror-foldgutter"],
			extraKeys: { "Ctrl-Q": (cm) => { cm.foldCode(cm.getCursor()); } },
		};
		
		elements.forEach((element) => {
			{event name='javascriptInit'}
			
			if (element.codemirror) {
				for (const key in config) {
					if (config.hasOwnProperty(key)) {
						element.codemirror.setOption(key, config[key]);
					}
				}
			}
			else {
				element.codemirror = CodeMirror.fromTextArea(element, config);
				element.codemirror.foldCode(CodeMirror.Pos(13, 0));
				const oldToTextArea = element.codemirror.toTextArea;
				element.codemirror.toTextArea = () => {
					oldToTextArea();
					element.codemirror = null;
				};
			}
			
			setTimeout(() => {
				element.codemirror.refresh();
			}, 250);
			setTimeout(() => {
				element.codemirror.refresh();
			}, 1000);
			
			const tab = DomTraverse.parentByClass(element, 'tabMenuContent');
			if (tab !== null) {
				const name = elData(tab, 'name');
				const tabMenu = DomTraverse.parentByClass(tab, 'tabMenuContainer');
				let scrollPosition = null;
				
				EventHandler.add('com.woltlab.wcf.simpleTabMenu_' + DomUtil.identify(tabMenu), 'select', (data) => {
					if (data.activeName === name) {
						element.codemirror.refresh();
						if (scrollPosition !== null) element.codemirror.scrollTo(null, scrollPosition);
					}
				});
				
				EventHandler.add('com.woltlab.wcf.simpleTabMenu_' + DomUtil.identify(tabMenu), 'beforeSelect', (data) => {
					if (data.tabName === name) {
						scrollPosition = element.codemirror.getScrollInfo().top;
					}
				});
			}
			
			let scrollOffsetStorage = element;
			do {
				scrollOffsetStorage = scrollOffsetStorage.nextElementSibling;
			} while (scrollOffsetStorage && !scrollOffsetStorage.classList.contains('codeMirrorScrollOffset'));
			if (scrollOffsetStorage) {
				element.codemirror.scrollTo(null, scrollOffsetStorage.value);
				element.codemirror.on('scroll', (cm) => {
					scrollOffsetStorage.value = cm.getScrollInfo().top;
				});
			}
		});
	});
</script>
