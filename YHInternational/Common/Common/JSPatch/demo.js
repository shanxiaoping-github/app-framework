function log(msg){
    require('UIAlertView');
    var alert = UIAlertView.alloc().init();
    if(typeof msg == 'object'){
        msg= JSON.stringify(msg);
    }
    alert.setMessage(msg+'');
    alert.addButtonWithTitle('ok');
    alert.show();
}

defineClass('BBGPhoneSeckillContentCell', {
            updateCellWith: function(model) {
            require('NSURL');
            var weakSelf = __weak(self);
            self.goodsImage().sd__setImageWithURL(NSURL.URLWithString(model.imageUrl()));
            self.goodsName().setText(model.productName());
            self.priceView().setUnCrossPrice(model.unCrosedPrice());
            self.priceView().setCrossPrice(model.crossedPrice());
            self.priceView().layoutSubviews();
            }
            })

defineClass('BBGPhoneSeckillMainCell', {
            updateCellWith_Time_sign_section: function(model, time, sign, section) {
            require('NSURL,NSString,NSDateFormatter,BBGConfiguration');
            num = section;
            if (sign.isEqualToString("0")) {
            self.addAnimation();
            }
            var weakSelf = __weak(self);
            var timeArr = time.startDate().toJS().split(" ");
            
            var yearArr = timeArr[0].split("-");
            
            var hourArr = timeArr[1].split(":")
            
            var t1 = yearArr[2];
            var t2 = hourArr[0];
            
            var title = t1+'日'+t2+'时开抢';
            self.lightningLab().setText(title);
            
            self.goodsImage().sd__setImageWithURL(NSURL.URLWithString(model.imageUrl()));
            self.goodsName().setText(model.productName());
            self.priceView().setUnCrossPrice(model.unCrosedPrice());
            self.priceView().setCrossPrice(model.crossedPrice());
            self.priceView().layoutSubviews();
            
            var formatter = NSDateFormatter.alloc().init();
            formatter.setDateFormat("YYYY-MM-dd HH:mm:ss");
            var startDate = formatter.dateFromString(time.startDate());
            var sysDate = BBGConfiguration.sharedInstance().getCurrentServerTime();
            var start = startDate.timeIntervalSince1970();
            var sys = sysDate.timeIntervalSince1970();
            self.countDown_andStart(sys, start);
            
            }
            })

defineClass('BBGAddressView', {
            setRegionList: function(regionList) {
            require('NSMutableArray,BBGRegion,NSArray,NSDictionary');
            
            if(regionList){
            var regionMutableList = NSMutableArray.arrayWithArray(regionList);
            var havedUpdateZhongshan = NO;
            var havedUpdateDongguan = NO;
            for (var i = 0; i < regionList.count(); i++) {
            var provinceRegion = regionList.objectAtIndex(i);
            
            if(provinceRegion){
            if (provinceRegion.regionId().isEqualToString("44")) {
            for (var j = 0; j < provinceRegion.regionChildren().count(); j++) {
            if(provinceRegion.regionChildren()){
            var cityRegion = provinceRegion.regionChildren().objectAtIndex(j);
            if (cityRegion.regionId().isEqualToString("442000000000")) {
            
            //中山
            for (var m = 0; m < cityRegion.regionChildren().count(); m++) {
            if(cityRegion.regionChildren()){
            var districtRegion = cityRegion.regionChildren().objectAtIndex(m);
            if (districtRegion.regionId().isEqualToString("442000501000")) {
            var newArray = NSMutableArray.array();
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("石岐区街道", "442000001000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("东区街道", "442000002000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("火炬开发区街道", "442000003000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("西区街道", "442000004000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("南区街道", "442000005000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("五桂山街道", "442000006000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("小榄镇", "442000100000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("黄圃镇", "442000101000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("民众镇", "442000102000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("东凤镇", "442000103000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("东升镇", "442000104000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("古镇镇", "442000105000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("沙溪镇", "442000106000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("坦洲镇", "442000107000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("港口镇", "442000108000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("三角镇", "442000109000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("横栏镇", "442000110000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("南头镇", "442000111000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("阜沙镇", "442000112000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("南朗镇", "442000113000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("三乡镇", "442000114000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("板芙镇", "442000115000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("大涌镇", "442000116000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("神湾镇", "442000117000"));
            
            
            var productArray = NSMutableArray.array();
            for (var n = 0; n < newArray.count(); n++) {
            var dic = newArray.objectAtIndex(n);
            var regionData = BBGRegion.alloc().init();
            regionData.setRegionId(dic.allKeys().objectAtIndex(0));
            regionData.setName(dic.allValues().objectAtIndex(0));
            regionData.setParentId("442000501000");
            productArray.addObject(regionData);
            }
            
            districtRegion.setRegionChildren(productArray);
            cityRegion.regionChildren().replaceObjectAtIndex_withObject(m, districtRegion);
            provinceRegion.regionChildren().replaceObjectAtIndex_withObject(j, cityRegion);
            regionMutableList.replaceObjectAtIndex_withObject(i, provinceRegion);
            havedUpdateZhongshan = YES;
            
            
            }
            }
            
            }
            
            }
            
            //东莞
            if (cityRegion.regionId().isEqualToString("441900000000")) {
            for (var m = 0; m < cityRegion.regionChildren().count(); m++) {
            if(cityRegion.regionChildren()){
            var districtRegion = cityRegion.regionChildren().objectAtIndex(m);
            if (districtRegion.regionId().isEqualToString("441900501000")) {
            
            var newArray = NSMutableArray.array();
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("东城街道", "441900003000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("南城街道", "441900004000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("万江街道", "441900005000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("莞城街道", "441900006000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("石碣镇", "441900101000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("石龙镇", "441900102000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("茶山镇", "441900103000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("石排镇", "441900104000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("企石镇", "441900105000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("横沥镇", "441900106000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("桥头镇", "441900107000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("谢岗镇", "441900108000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("东坑镇", "441900109000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("常平镇", "441900110000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("寮步镇", "441900111000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("樟木头镇", "441900112000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("大朗镇", "441900113000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("黄江镇", "441900114000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("清溪镇", "441900115000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("塘厦镇", "441900116000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("凤岗镇", "441900117000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("大岭山镇", "441900118000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("长安镇", "441900119000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("虎门镇", "441900121000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("厚街镇", "441900122000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("沙田镇", "441900123000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("道滘镇", "441900124000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("洪梅镇", "441900125000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("麻涌镇", "441900126000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("望牛墩镇", "441900127000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("中堂镇", "441900128000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("高埗镇", "441900129000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("松山湖管委会", "441900401000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("虎门港管委会", "441900402000"));
            newArray.addObject(NSDictionary.dictionaryWithObject_forKey("东莞生态园", "441900403000"));
            
            
            var productArray = NSMutableArray.array();
            for (var n = 0; n < newArray.count(); n++) {
            var dic = newArray.objectAtIndex(n);
            var regionData = BBGRegion.alloc().init();
            regionData.setRegionId(dic.allKeys().objectAtIndex(0));
            regionData.setName(dic.allValues().objectAtIndex(0));
            regionData.setParentId("441900501000");
            productArray.addObject(regionData);
            }
            
            districtRegion.setRegionChildren(productArray);
            cityRegion.regionChildren().replaceObjectAtIndex_withObject(m, districtRegion);
            provinceRegion.regionChildren().replaceObjectAtIndex_withObject(j, cityRegion);
            regionMutableList.replaceObjectAtIndex_withObject(i, provinceRegion);
            havedUpdateZhongshan = YES;
            
            
            }
            }
            
            }
            
            }
            
            }
            }
            }
            
            }
            
            }
            
            self.setValue_forKey(regionMutableList, "_regionList");
            }
            
            }
            })