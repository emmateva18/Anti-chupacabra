var translateText = {

    "headerOnArticle1": {
        'en': `The future is ahead`,

        'bg': `Бъдещето е напред`
    },
    "article1": {
        'en': `Every year less and less turtles hatch from their egg and begin their struggle for survival.`,

        'bg': `Всяка година все по-малко костенурки се излюпват от тяхното яйце и започват своята борба за оцеляване.`
    },
    "headerOnArticle2": {
        'en': `They need our help`,
        'bg': `Нуждаят се от нашата помощ`
    },
    "article2": {
        'en': `We can help them thrive and regain the diversity in species they once had.`,
        'bg': `Можем да им помогнем да процъфтяват и да възвърнат разнообразието от видове, които някога са имали.`
    },
    "article2": {
        'en': `We can help them thrive and regain the diversity in species they once had.`,
        'bg': `Можем да им помогнем да процъфтяват и да възвърнат разнообразието от видове, които някога са имали.`
    },
    "headerOnArticle3": {
        'en': `There are only a few left`,
        'bg': `Останаха само няколко`
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