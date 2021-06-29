var translateText = {

    "headerOnArticle1": {
        'en': `The future is ahead`,

        'bg': `Бъдещето е напред`
    },
    "testText": {
        'en': `Every year less and less turtles hatch from their egg and begin their struggle for survival.`,

        'bg': `az sum na bg`
    },
    "": {
        'en': ``,
        'bg': ``
    }
}

var currentLanguage = 'en';

function replaceElementText(item, text) {
    if (!item.is("button")) {
        item.html(text);
    } else {
        item.text(text);
    }
}

function translateLabel(langId) {
    currentLanguage = langId;
    console.log(currentLanguage)
        // Gets all tags that have 'data-lang' attribute present
    $("[data-lang]")
        .each(function() {
            let item = $(this);
            if (translateText.hasOwnProperty(item.data("lang")) && translateText[item.data("lang")].hasOwnProperty(langId)) {
                let text = translateText[item.data("lang")][langId];
                replaceElementText(item, text);
            } else {
                replaceElementText(item, "<font color='red'>" + item.data("lang") + "</font>");
            }
        })
};

function getTranslatedText(elementId) {
    return translateText[elementId][currentLanguage];
}