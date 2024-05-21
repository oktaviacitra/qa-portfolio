const {By, Builder, WebElementCondition. uuntil} = require('selenium-webdriver');
const assert = require('assert');

(async function searchItemTest(){
    let driver = await new Builder().forBrowser('chrome').build();
    await driver.get('https://admlucid.com/Golf');
    
    await driver.manage().setTimeouts({implicit: 500});
    await driver.manage().window().maximize();
    
    let searchBox = await driver.findElement(By.name('SearchString'));
    await searchBox.sendKeys('Tiger A');
    
    let searchButton = await driver.findElement(By.css('body > div.container > main > table:nth-child(8) > tbody > tr > td:nth-child(1) > form > button'));
    await searchButton.click();
    
    let actualValue = await driver.findElement(By.xpath('/html/body/div[1]/main/table[2]/tbody/tr/td[1]')).getText().trim();
    assert.equal('Tiger A', actualValue);
    
    try {
        
    } catch(e) {
        console.log(e);
    } finally {
        await driver.quit;
    }
}())
