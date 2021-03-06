var coordConvert = {
    "安道尔" : [1.5,42.5],
    "阿联酋" : [54,24],
    "阿富汗" : [65,33],
    "安提瓜和巴布达" : [-61.8,17.05],
    "安圭拉岛" : [-63.1667,18.25],
    "阿尔巴尼亚" : [20,41],
    "亚美尼亚" : [45,40],
    "安哥拉" : [18.5,-12.5],
    "阿根廷" : [-64,-34],
    "奥地利" : [13.3333,47.3333],
    "澳大利亚" : [133,-27],
    "阿塞拜疆" : [47.5,40.5],
    "波黑" : [18,44],
    "巴巴多斯" : [-59.5333,13.1667],
    "孟加拉国" : [90,24],
    "比利时" : [4,50.8333],
    "布基纳法索" : [-2,13],
    "保加利亚" : [25,43],
    "巴林" : [50.55,26],
    "布隆迪" : [30,-3.5],
    "贝宁" : [2.25,9.5],
    "百慕大群岛" : [-64.75,32.3333],
    "文莱" : [114.6667,4.5],
    "玻利维亚" : [-65,-17],
    "巴西" : [-55,-10],
    "巴哈马" : [-76,24.25],
    "不丹" : [90.5,27.5],
    "博茨瓦纳" : [24,-22],
    "白俄罗斯" : [28,53],
    "伯利兹" : [-88.75,17.25],
    "加拿大" : [-100,54],
    "民主刚果" : [25,0],
    "中非" : [21,7],
    "刚果" : [15,-1],
    "瑞士" : [8,47],
    "科特迪瓦" : [-5,8],
    "库克群岛" : [-159.7667,-21.2333],
    "智利" : [-71,-30],
    "喀麦隆" : [12,6],
    "中国" : [105,35],
    "哥伦比亚" : [-72,4],
    "哥斯达黎加" : [-84,10],
    "古巴" : [-80,21.5],
    "佛得角" : [-24,16],
    "塞浦路斯" : [33,35],
    "捷克" : [15.5,49.75],
    "德国" : [9,51],
    "吉布提" : [43,11.5],
    "丹麦" : [10,56],
    "多米尼加" : [-70.6667,19],
    '阿尔及利亚' : [3,28],
    "厄瓜多尔" : [-77.5,-2],
    "爱沙尼亚" : [26,59],
    "埃及" : [30,27],
    "厄立特里亚" : [39,15],
    "西班牙" : [-4,40],
    "埃塞俄比亚" : [38,8],
    "芬兰" : [26,62],
    "斐济" : [175,-18],
    "法国" : [2,46],
    "加蓬" : [11.75,-1],
    "英国" : [-2,54],
    "格林纳达" : [-61.6667,12.1167],
    "格鲁吉亚" : [43.5,42],
    "法属圭亚那" : [-53,4],
    "加纳" : [-2,8],
    "直布罗陀" : [-5.3667,36.1833],
    "冈比亚" : [-16.5667,13.4667],
    "几内亚" : [-10,11],
    "赤道几内亚" : [10,2],
    "希腊" : [22,39],
    "危地马拉" : [-90.25,15.5],
    "关岛" : [144.7833,13.4667],
    "几内亚比绍" : [-15,12],
    "圭亚那" : [-59,5],
    "洪都拉斯" : [-86.5,15],
    "克罗地亚" : [15.5,45.1667],
    "海地" : [-72.4167,19],
    "匈牙利" : [20,47],
    "印度尼西亚" : [120,-5],
    "爱尔兰" : [-8,53],
    "以色列" : [34.75,31.5],
    "印度" : [77,20],
    "伊拉克" : [44,33],
    "伊朗" : [53,32],
    "冰岛" : [-18,65],
    "意大利" : [12.8333,42.8333],
    "牙买加" : [-77.5,18.25],
    "约旦" : [36,31],
    "日本" : [138,36],
    "肯尼亚" : [38,1],
    "吉尔吉斯斯坦" : [75,41],
    "柬埔寨" : [105,13],
    "科摩罗" : [44.25,-12.1667],
    "朝鲜" : [127,40],
    "韩国" : [127.5,37],
    "科威特" : [47.6581,29.3375],
    "哈萨克斯坦" : [68,48],
    "老挝" : [105,18],
    "黎巴嫩" : [35.8333,33.8333],
    "圣卢西亚" : [-61.1333,13.8833],
    "列支敦士登" : [9.5333,47.1667],
    "斯里兰卡" : [81,7],
    "利比里亚" : [-9.5,6.5],
    "莱索托" : [28.5,-29.5],
    "立陶宛" : [24,55],
    "卢森堡" : [6,49.75],
    "拉脱维亚" : [25,57],
    "利比亚" : [17,25],
    "摩洛哥" : [-5,32],
    "摩纳哥" : [7.4,43.7333],
    "摩尔多瓦" : [29,47],
    "黑山" : [19.4,42.5],
    "马达加斯加" : [47,-20],
    "马其顿" : [22,41.8333],
    "马里" : [-4,17],
    "缅甸" : [98,22],
    "蒙古" : [105,46],
    "毛里塔尼亚" : [-12,20],
    "蒙特塞拉特岛" : [-62.2,16.75],
    "马耳他" : [14.5833,35.8333],
    "毛里求斯" : [57.55,-20.2833],
    "马尔代夫" : [73,3.25],
    "马拉维" : [34,-13.5],
    "墨西哥" : [-102,23],
    "马来西亚" : [112.5,2.5],
    "莫桑比克" : [35,-18.25],
    "纳米比亚" : [17,-22],
    "尼日尔" : [8,16],
    "尼日利亚" : [8,10],
    "尼加拉瓜" : [-85,13],
    "荷兰" : [5.75,52.5],
    "挪威" : [10,62],
    "尼泊尔" : [84,28],
    "瑙鲁" : [166.9167,-0.5333],
    "新西兰" : [174,-41],
    "阿曼" : [57,21],
    "巴拿马" : [-80,9],
    "秘鲁" : [-76,-10],
    "巴布亚新几内亚" : [147,-6],
    "菲律宾" : [122,13],
    "巴基斯坦" : [70,30],
    "波兰" : [20,52],
    "波多黎各" : [-66.5,18.25],
    "约旦河西岸" : [35.25,32],
    "葡萄牙" : [-8,39.5],
    "巴拉圭" : [-58,-23],
    "卡塔尔" : [51.25,25.5],
    "罗马尼亚" : [25,46],
    "塞尔维亚共和国" : [21,44],
    "俄罗斯" : [100,60],
    "卢旺达" : [30,-2],
    "沙特阿拉伯" : [45,25],
    "所罗门群岛" : [159,-8],
    "塞舌尔" : [55.6667,-4.5833],
    "苏丹" : [30,15],
    "瑞典" : [15,62],
    "新加坡" : [103.8,1.3667],
    "斯洛文尼亚" : [15,46],
    "斯洛伐克" : [19.5,48.6667],
    "塞拉利昂" : [-11.5,8.5],
    "塞内加尔" : [-14,14],
    "索马里" : [49,10],
    "苏里南" : [-56,4],
    "萨尔瓦多" : [-88.9167,13.8333],
    "叙利亚" : [38,35],
    "斯威士兰" : [31.5,-26.5],
    "乍得" : [19,15],
    "多哥" : [1.1667,8],
    "泰国" : [100,15],
    "塔吉克斯坦" : [71,39],
    "土库曼斯坦" : [60,40],
    "突尼斯" : [9,34],
    "土耳其" : [35,39],
    "特立尼达和多巴哥" : [-61,11],
    "坦桑尼亚" : [35,-6],
    "乌克兰" : [32,49],
    "乌干达" : [32,1],
    "美国" : [-97,38],
    "乌拉圭" : [-56,-33],
    "乌兹别克斯坦" : [64,41],
    "委内瑞拉" : [-66,8],
    "越南" : [106,16],
    "也门" : [48,15],
    "南非" : [24,-29],
    "赞比亚" : [30,-15],
    "津巴布韦" : [30,-20]
};