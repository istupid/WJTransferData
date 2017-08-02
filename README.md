# WJTransferData
朋友公司处理原数据问题
[
  ‘商行||华北||龙华西路店',
  ‘商行||华北||龙华北路店’,
  ‘农行||华东||龙华北路店’,
  ‘农行||总店’
]
=>
[
  [商行, 华北, 龙华西路店],
  [商行, 华北, 龙华北路店],
  [农行, 华东, 龙华北路店],
  [农行, 总店]
]
=>
[
  {
    title: 商行,
    items: [
      {
        title: 华北,
        items: [
          {
            title: 龙华西路店,
            items: []
          },
          {
            title: 龙华北路店,
            items: []
          }
        ]
      }
    ]
  },
  {
    title: 农行,
    items: [
      {
        title: 华东,
        items: [
          {
            title: 龙华北路店,
            items: []
          }
        ]
      },
      {
        title: 总店,
        items: []
      }
    ]
  }
]
