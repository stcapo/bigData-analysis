<template>
<div>
	<div class="container" :style='{"minHeight":"100vh","alignItems":"center","background":"url(http://codegen.caihongy.cn/20230106/58eb0ca95fe94ea3912632230dc4f6d4.jpg) no-repeat center top /  100% 100%,#fff","display":"flex","width":"100%","backgroundSize":"cover","backgroundPosition":"center center","backgroundRepeat":"no-repeat","justifyContent":"center"}'>
		<el-form ref="loginForm" :model="loginForm" :style='{"padding":"20px  240px 40px  40px","boxShadow":"0 0px 0px rgba(0, 0, 0, .1)","margin":"0","borderColor":"#98c6e2 #5fa6d0 #98c6e2 #5fa6d0","outline":"1px solid #eee","borderRadius":"0px","background":"#fff","borderWidth":"8px 16px 8px 16px","width":"800px","position":"relative","borderStyle":"solid","height":"auto"}' :rules="rules">
			<div v-if="true" :style='{"margin":"0 0 4px","color":"#5fa6d0","textAlign":"center","width":"100%","lineHeight":"44px","fontSize":"22px","textShadow":"0px 0px 0px rgba(64, 158, 255, .5)"}'>USER / LOGIN</div>
			<div v-if="true" :style='{"boxShadow":"inset 0px 0px 0px 0px #c5f1c0","margin":"0px 0 20px","borderColor":"#98c6e2 #5fa6d0 #98c6e2 #5fa6d0","color":"#333","textAlign":"center","background":"#fff","borderWidth":"8px 16px 8px 16px","width":"100%","lineHeight":"44px","fontSize":"16px","borderStyle":"solid","textShadow":"0px 0px 0px rgba(64, 158, 255, .5)"}'>基于BS招投标管理系统 登录</div>
			<el-form-item v-if="loginType==1" class="list-item" :style='{"width":"80%","margin":"0 auto 10px"}' prop="username">
				<div v-if="false" :style='{"width":"64px","lineHeight":"44px","fontSize":"14px","color":"rgba(64, 158, 255, 1)"}'>账号：</div>
				<input :style='{"border":"2px solid #98c6e2","padding":"0 10px","color":"#333","borderRadius":"4px","width":"100%","fontSize":"14px","height":"44px"}' v-model="loginForm.username" placeholder="请输入账户">
			</el-form-item>
			<el-form-item v-if="loginType==1" class="list-item" :style='{"width":"80%","margin":"0 auto 10px"}' prop="password">
				<div v-if="false" :style='{"width":"64px","lineHeight":"44px","fontSize":"14px","color":"rgba(64, 158, 255, 1)"}'>密码：</div>
				<input :style='{"border":"2px solid #98c6e2","padding":"0 10px","color":"#333","borderRadius":"4px","width":"100%","fontSize":"14px","height":"44px"}' v-model="loginForm.password" placeholder="请输入密码" type="password">
			</el-form-item>
			<el-form-item v-if="roles.length>1" class="list-type" :style='{"width":"80%","margin":"20px auto"}' prop="role">
				<el-radio v-model="loginForm.tableName" :label="item.tableName" v-for="(item, index) in roles" :key="index" @change.native="getCurrentRow(item)">{{item.roleName}}</el-radio>
			</el-form-item>
			<el-form-item :style='{"width":"80%","margin":"0"}'>
				<el-button v-if="loginType==1" :style='{"border":"0","cursor":"pointer","padding":"0 10px","margin":"0","borderColor":"#98c6e2 #5fa6d0 #98c6e2 #5fa6d0","color":"#333","bottom":"-125px","display":"inline-block","minWidth":"140px","outline":"none","borderRadius":"4px","left":"160px","background":"#fff","borderWidth":"8px 16px 8px 16px","width":"auto","fontSize":"16px","position":"absolute","borderStyle":"solid","height":"56px"}' @click="submitForm('loginForm')">登录</el-button>
				<el-button v-if="loginType==1" :style='{"border":"0","cursor":"pointer","padding":"0 24px","margin":"0 5px","outline":"none","color":"#fff","borderRadius":"4px","background":"rgba(64, 158, 255, 1)","display":"none","width":"auto","fontSize":"14px","height":"44px"}' @click="resetForm('loginForm')">重置</el-button>
                <el-upload v-if="loginType==2" :action="baseUrl + 'file/upload'" :show-file-list="false" :on-success="faceLogin">
                    <el-button :style='{"border":"0","cursor":"pointer","padding":"0 10px","margin":"0","borderColor":"#98c6e2 #5fa6d0 #98c6e2 #5fa6d0","color":"#333","bottom":"-125px","display":"inline-block","minWidth":"140px","outline":"none","borderRadius":"4px","left":"160px","background":"#fff","borderWidth":"8px 16px 8px 16px","width":"auto","fontSize":"16px","position":"absolute","borderStyle":"solid","height":"56px"}'>人脸识别登录</el-button>
                </el-upload>
			</el-form-item>
			<div :style='{"margin":"0 0px 0 0","top":"70px","flexWrap":"wrap","display":"flex","width":"200px","position":"absolute","right":"30px","justifyContent":"flex-end","height":"100%"}'>
			<router-link :style='{"cursor":"pointer","padding":"0 10px","margin":"0 0px 20px 0","borderColor":"#98c6e2 #5fa6d0 #98c6e2 #5fa6d0","color":"#333","textDecoration":"none","minWidth":"120px","background":"#f6f6f6","borderWidth":"8px 16px 8px 16px","width":"auto","fontSize":"16px","lineHeight":"36px","borderStyle":"solid","height":"50px"}' :to="{path: '/register', query: {role: item.tableName,pageFlag:'register'}}" v-if="item.hasFrontRegister=='是'" v-for="(item, index) in roles" :key="index">注册{{item.roleName.replace('注册','')}}</router-link>
			</div>
		</el-form>
    </div>
</div>
</template>

<script>

export default {
	//数据集合
	data() {
		return {
            baseUrl: this.$config.baseUrl,
            loginType: 1,
			roleMenus: [{"backMenu":[{"child":[{"appFrontIcon":"cuIcon-shop","buttons":["新增","查看","修改","删除","审核"],"menu":"招标单位","menuJump":"列表","tableName":"zhaobiaodanwei"}],"menu":"招标单位管理"},{"child":[{"appFrontIcon":"cuIcon-form","buttons":["新增","查看","修改","删除"],"menu":"评标专家","menuJump":"列表","tableName":"pingbiaozhuanjia"}],"menu":"评标专家管理"},{"child":[{"appFrontIcon":"cuIcon-phone","buttons":["新增","查看","修改","删除"],"menu":"投标单位","menuJump":"列表","tableName":"toubiaodanwei"}],"menu":"投标单位管理"},{"child":[{"appFrontIcon":"cuIcon-present","buttons":["查看","修改","删除"],"menu":"招标项目","menuJump":"列表","tableName":"zhaobiaoxiangmu"}],"menu":"招标项目管理"},{"child":[{"appFrontIcon":"cuIcon-present","buttons":["查看","修改","删除"],"menu":"投标记录","menuJump":"列表","tableName":"toubiaojilu"}],"menu":"投标记录管理"},{"child":[{"appFrontIcon":"cuIcon-explore","buttons":["查看","修改","删除"],"menu":"评标记录","menuJump":"列表","tableName":"pingbiaojilu"}],"menu":"评标记录管理"},{"child":[{"appFrontIcon":"cuIcon-medal","buttons":["查看","修改","删除"],"menu":"归档保存","menuJump":"列表","tableName":"guidangbaocun"}],"menu":"归档保存管理"},{"child":[{"appFrontIcon":"cuIcon-brand","buttons":["查看","修改"],"menu":"系统简介","tableName":"systemintro"},{"appFrontIcon":"cuIcon-full","buttons":["查看","修改"],"menu":"轮播图管理","tableName":"config"},{"appFrontIcon":"cuIcon-news","buttons":["新增","查看","修改","删除"],"menu":"公告信息","tableName":"news"},{"appFrontIcon":"cuIcon-full","buttons":["查看","修改"],"menu":"关于我们","tableName":"aboutus"}],"menu":"系统管理"}],"frontMenu":[{"child":[{"appFrontIcon":"cuIcon-goodsnew","buttons":["查看","投标"],"menu":"招标项目列表","menuJump":"列表","tableName":"zhaobiaoxiangmu"}],"menu":"招标项目模块"}],"hasBackLogin":"是","hasBackRegister":"否","hasFrontLogin":"否","hasFrontRegister":"否","roleName":"管理员","tableName":"users"},{"backMenu":[{"child":[{"appFrontIcon":"cuIcon-present","buttons":["新增","查看","修改","删除"],"menu":"招标项目","menuJump":"列表","tableName":"zhaobiaoxiangmu"}],"menu":"招标项目管理"},{"child":[{"appFrontIcon":"cuIcon-present","buttons":["查看"],"menu":"投标记录","menuJump":"列表","tableName":"toubiaojilu"}],"menu":"投标记录管理"},{"child":[{"appFrontIcon":"cuIcon-explore","buttons":["查看","归档"],"menu":"评标记录","menuJump":"列表","tableName":"pingbiaojilu"}],"menu":"评标记录管理"},{"child":[{"appFrontIcon":"cuIcon-medal","buttons":["查看"],"menu":"归档保存","menuJump":"列表","tableName":"guidangbaocun"}],"menu":"归档保存管理"}],"frontMenu":[{"child":[{"appFrontIcon":"cuIcon-goodsnew","buttons":["查看","投标"],"menu":"招标项目列表","menuJump":"列表","tableName":"zhaobiaoxiangmu"}],"menu":"招标项目模块"}],"hasBackLogin":"是","hasBackRegister":"是","hasFrontLogin":"否","hasFrontRegister":"否","roleName":"招标单位","tableName":"zhaobiaodanwei"},{"backMenu":[{"child":[{"appFrontIcon":"cuIcon-present","buttons":["查看","审核"],"menu":"招标项目","menuJump":"列表","tableName":"zhaobiaoxiangmu"}],"menu":"招标项目管理"},{"child":[{"appFrontIcon":"cuIcon-present","buttons":["查看","审核","专家评标"],"menu":"投标记录","menuJump":"列表","tableName":"toubiaojilu"}],"menu":"投标记录管理"},{"child":[{"appFrontIcon":"cuIcon-explore","buttons":["查看","修改"],"menu":"评标记录","menuJump":"列表","tableName":"pingbiaojilu"}],"menu":"评标记录管理"}],"frontMenu":[{"child":[{"appFrontIcon":"cuIcon-goodsnew","buttons":["查看","投标"],"menu":"招标项目列表","menuJump":"列表","tableName":"zhaobiaoxiangmu"}],"menu":"招标项目模块"}],"hasBackLogin":"是","hasBackRegister":"否","hasFrontLogin":"否","hasFrontRegister":"否","roleName":"评标专家","tableName":"pingbiaozhuanjia"},{"backMenu":[{"child":[{"appFrontIcon":"cuIcon-present","buttons":["查看"],"menu":"投标记录","menuJump":"列表","tableName":"toubiaojilu"}],"menu":"投标记录管理"},{"child":[{"appFrontIcon":"cuIcon-explore","buttons":["查看"],"menu":"评标记录","menuJump":"列表","tableName":"pingbiaojilu"}],"menu":"评标记录管理"}],"frontMenu":[{"child":[{"appFrontIcon":"cuIcon-goodsnew","buttons":["查看","投标"],"menu":"招标项目列表","menuJump":"列表","tableName":"zhaobiaoxiangmu"}],"menu":"招标项目模块"}],"hasBackLogin":"是","hasBackRegister":"否","hasFrontLogin":"是","hasFrontRegister":"是","roleName":"投标单位","tableName":"toubiaodanwei"}],
			loginForm: {
				username: '',
				password: '',
				tableName: '',
				code: '',
			},
			role: '',
            roles: [],
			rules: {
				username: [
					{ required: true, message: '请输入账户', trigger: 'blur' }
				],
				password: [
					{ required: true, message: '请输入密码', trigger: 'blur' }
				]
			},
			codes: [{
				num: 1,
				color: '#000',
				rotate: '10deg',
				size: '16px'
			}, {
				num: 2,
				color: '#000',
				rotate: '10deg',
				size: '16px'
			}, {
				num: 3,
				color: '#000',
				rotate: '10deg',
				size: '16px'
			}, {
				num: 4,
				color: '#000',
				rotate: '10deg',
				size: '16px'
			}]
		}
	},
	created() {
        for(let item in this.roleMenus) {
            if(this.roleMenus[item].hasFrontLogin=='是') {
                this.roles.push(this.roleMenus[item]);
            }
        }
	},
	mounted() {
	},
    //方法集合
    methods: {
		randomString() {
			var len = 4;
			var chars = [
			  'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k',
			  'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
			  'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G',
			  'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R',
			  'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '0', '1', '2',
			  '3', '4', '5', '6', '7', '8', '9'
			]
			var colors = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f']
			var sizes = ['14', '15', '16', '17', '18']
			
			var output = []
			for (var i = 0; i < len; i++) {
			  // 随机验证码
			  var key = Math.floor(Math.random() * chars.length)
			  this.codes[i].num = chars[key]
			  // 随机验证码颜色
			  var code = '#'
			  for (var j = 0; j < 6; j++) {
			    var key = Math.floor(Math.random() * colors.length)
			    code += colors[key]
			  }
			  this.codes[i].color = code
			  // 随机验证码方向
			  var rotate = Math.floor(Math.random() * 45)
			  var plus = Math.floor(Math.random() * 2)
			  if (plus == 1) rotate = '-' + rotate
			  this.codes[i].rotate = 'rotate(' + rotate + 'deg)'
			  // 随机验证码字体大小
			  var size = Math.floor(Math.random() * sizes.length)
			  this.codes[i].size = sizes[size] + 'px'
			}
		},
      getCurrentRow(row) {
        this.role = row.roleName;
      },
      submitForm(formName) {
        if (this.roles.length!=1) {
            if (!this.role) {
                this.$message.error("请选择登录用户类型");
                return false;
            }
        } else {
            this.role = this.roles[0].roleName;
            this.loginForm.tableName = this.roles[0].tableName;
        }
        this.$refs[formName].validate((valid) => {
          if (valid) {
            this.$http.get(`${this.loginForm.tableName}/login`, {params: this.loginForm}).then(res => {
              if (res.data.code === 0) {
                localStorage.setItem('Token', res.data.token);
                localStorage.setItem('UserTableName', this.loginForm.tableName);
                localStorage.setItem('username', this.loginForm.username);
                localStorage.setItem('adminName', this.loginForm.username);
                localStorage.setItem('sessionTable', this.loginForm.tableName);
                localStorage.setItem('role', this.role);
                localStorage.setItem('keyPath', this.$config.indexNav.length+2);
                this.$router.push('/index/center');
                this.$message({
                  message: '登录成功',
                  type: 'success',
                  duration: 1500,
                });
              } else {
                this.$message.error(res.data.msg);
              }
            });
          } else {
            return false;
          }
        });
      },
      resetForm(formName) {
        this.$refs[formName].resetFields();
      }
    }
  }
</script>

<style rel="stylesheet/scss" lang="scss" scoped>
	.container {
		position: relative;
		background: url(http://codegen.caihongy.cn/20230106/58eb0ca95fe94ea3912632230dc4f6d4.jpg) no-repeat center top /  100% 100%,#fff;
		
		.el-form-item {
		  & /deep/ .el-form-item__content {
		    width: 100%;
		  }
		}
		
		.list-item /deep/ .el-input .el-input__inner {
			border: 2px solid #98c6e2;
			border-radius: 4px;
			padding: 0 10px;
			color: #333;
			width: 100%;
			font-size: 14px;
			height: 44px;
		}
		
		.list-code /deep/ .el-input .el-input__inner {
			border: 2px solid #98c6e2;
			border-radius: 4px;
			padding: 0 10px;
			outline: none;
			color: #333;
			display: inline-block;
			vertical-align: middle;
			width: calc(100% - 114px);
			font-size: 14px;
			height: 44px;
		}
		
		.list-type /deep/ .el-radio__input .el-radio__inner {
			background: rgba(53, 53, 53, 0);
			border-color: #666666;
		}
		.list-type /deep/ .el-radio__input.is-checked .el-radio__inner {
			background: #5fa6d0;
			border-color: #5fa6d0;
		}
		.list-type /deep/ .el-radio__label {
			color: #666666;
			font-size: 14px;
		}
		.list-type /deep/ .el-radio__input.is-checked+.el-radio__label {
			color: #5fa6d0;
			font-size: 14px;
		}
	}
</style>
