---
title: "中国医学百科全书_part06"
category: 中医
type: tcm
---


<div align="center">

不同 $ \lambda $值的Poisson分布

</div>

者相等或相近，按Poisson分布拟合（见“Poisson分布拟合”条）和拟合优度检验（见“拟合优度检验”条）的步骤进行。$\textcircled{2}$样本计算X与总体参数 $\lambda$ 有显著差别的假设检验。$\textcircled{3}$两样本比较及多组样本比较等。

样本计数X与总体参数 $\lambda$比较 原假设： $\lambda_{\mathrm{x}} = \lambda_0$。 $\lambda_{\mathrm{x}}$ 为样本所代表总体值。从样本值X求得总体 $\lambda_{\mathrm{x}}$ 的可信区间。如 $\lambda_0$ 在这可信区间范围之内，则接受原假设，否则拒绝原假设。

(1) 当 $ X\leqslant 50 $时，可查附录四表11即得。

(2) 当 $X > 50$ 时， $\lambda_{x}$ 的可信区间可用下式计算：

$$
[ \sqrt {X} - 1. 9 6 (0. 5) ] ^ {2}, [ \sqrt {X + 1} + 1. 9 6 (0. 5) ] ^ {2}
$$

上式是利用Poisson分布的一个特性，呈Poisson分布的变量X，用平方根变换后，其方差为一常数， $(0.5)^{2}$ 。

两个呈Poisson分布样本的比较 检验的原假设为 $\lambda_1 = \lambda_2$ ，$\lambda_1$ 与 $\lambda_2$ 分别为第 个样本与第二个样本所代表的总体均值。两个样本各有 $n_1$ 与 $n_2$ 个数据，可用Z检验。

$$
Z = \frac {\bar {X} _ {1} - \bar {X} _ {2}}{\sqrt {\frac {\bar {X} _ {1}}{n _ {1}} + \frac {\bar {X} _ {2}}{n _ {2}}}}
$$

当 $ \mathrm{n}_{1}=\mathrm{n}_{2} $时，

$$
Z = \frac {\sum X _ {1} - \sum X _ {2}}{\sqrt {\sum X _ {1} + \sum X _ {2}}}
$$

式(4)适用于样本计数较大时的比较，如 $\sum X_{1} + \sum X_{2} \geq 20$ 。若 $\sum X_{1} + \sum X_{2} < 20$ ，则用式(5)作连续性校正；

$$
Z = \frac {\left| \sum X _ {1} - \sum X _ {2} \right| - 1}{\sqrt {\sum X _ {1} + \sum X _ {2}}}
$$

两个以上呈 Poisson 分布样本的比较 原假设为 $\lambda_{1} = \lambda_{2} = \dots = \lambda_{K} = \lambda$ 。

当所有样本中变量的单位体积（或时间等）相同，变量X数值较大时，如 $x > 5$ 或组数 $> 15$，可用下式来检验各样本是否来自均数为 $\lambda$ 的总体。

$$
x ^ {2} = \frac {\sum \left(\mathrm {X} - \bar {\mathrm {X}}\right) ^ {2}}{\bar {\mathrm {X}}}, \text {自 由 度} = \mathrm {k} - 1
$$

如果样本单位体积（或时间等）不同，变量X数值较小，要进行多组比较，则用平方根变换的方法进行假设检验，步骤如下：

设k个样本的合并事件数为 $X_{k}$，合并体积（或时间）等为 $t_{k}$，则每个样本的平均事件数 $\lambda_{k} - \lambda_{1} / t_{10}$。假定全部样本来自均数为 $\lambda$ 的总体，$\lambda$ 的估计值 $\lambda$：

$$
\hat {\lambda} = \frac {\sum X _ {1}}{\sum t _ {j}}
$$

把全部样本分为 $ \hat{\lambda}_{1} < \hat{\lambda} $和 $ \hat{\lambda}_{1} > \hat{\lambda} $两组分别计算：

$$
Z _ {1} = \frac {\sqrt {X _ {1} + 1} - \sqrt {t _ {1} \lambda^ {0}}}{0 . 5}, \quad \text {当} \hat {\lambda} _ {1} < \hat {\lambda}
$$

$$
Z _ {t} = \frac {\sqrt {X _ {t}} - \sqrt {t _ {t} \hat {\lambda}}}{0 . 5}, \quad \text {当} \hat {\lambda} _ {t} > \hat {\lambda}
$$

然后计算 $ \chi^{2} $值，作 $ \chi^{2} $检验。

$$
\chi^ {2} = \sum_ {i = 1} ^ {k} Z _ {i} ^ {2} \quad \text {自由度} = k - 1
$$

$\chi^{2} > \chi^{2}_{005}$ 时，拒绝原假设，否则不拒绝。

例1 有人观察血细胞，计数泡中400个小格，共有细胞1447个，试求 $95\%$ 可信区间。

按公式（2）可算得：

下限为： $[\sqrt{400}-1.96(0.5)]^{2}=361.8$

例2 在两个经空气消毒过的病房中，分别各放置3个平肌，一定时后收起培养，得到的葡萄球菌菌落数分别为11、8.19和4.5.20，问两个病房的消毒效果是否一致？

因为 $n_{1} = n_{2}$ ，即两个病房的平皿数相同，

$$
\begin{array}{l} \sum x _ {1} = 1 1 + 8 + 1 9 = 3 8 \\ \sum x _ {2} = 4 + 5 + 2 0 = 2 9 \\ \end{array}
$$

用式（4）作检验，得

$$
Z = \frac {3 8 - 2 9}{\sqrt {3 8 + 2 9}} = 1. 1 0
$$

因为 $Z < 1.96, P > 0.05$ ，所以，可以认为两个病房的消毒效果九明显差别。

例3 在一经过空气消毒的病房内，6个地点各放置一个平底，放置时间一样。培养问地点菌球菌后得每平底1个地点菌球菌落数是11,7,14,18,9,11。培养不同地点的消毒效果是否不一致？

因为6个地点均放一个平画，故各组单位相等，这是比较多个单位体积相等的样本，可用式（6）计算 $x^{2}$ 值。

$$
\bar {X} = (1 1 \cdot 7 + 1 4 + 1 8 + 9 \cdot 1 1) \div 6 = 1 1. 6 6
$$

$$
\begin{array}{l} \chi^ {2} = \frac {1}{\bar {X}} \sum (X - \bar {X}) ^ {2} \\ - \frac {1}{1 1 . 6 6} \left[ (1 1 + 1 1. 6 6) ^ {2} + (7 - 1 1. 6 6) ^ {2} + (1 4 - 1 1. 6 6) ^ {2} \right. \\ + (1 8 - 1 1. 6 6) ^ {2} + (9 - 1 1. 6 6) ^ {2} + (1 1 - 1 1. 6 6) ^ {2} ] \\ = \frac {1}{1 1 . 6 6} \left[ (0. 6 6) ^ {2} + (4. 6 6) ^ {2} + (2. 3 4) ^ {2} + (6. 3 4) ^ {2} + (2. 6 6) ^ {2} \right. \\ + (0. 6 6) ^ {2} ] \\ - 6. 4 6 \\ \mathrm {自 由 度} = 6 - 1 = 5 \\ \end{array}
$$

查 $x^{2}$ 值表（附录四表16）， $x^{2}_{(0.05,5)} = 11.07$ 。因为 $x^{2} < x^{2}_{(0.05,5)}$ 所以 $P < 0.05$ ，说明不同地点的消毒效果无明显差别。

## 二项分布数据假设检验

二项分布(binomial distribution)是描述具有每一观察单位只有两个相互对立的结果（如生与死，阳性与阴性）的数据的一种离散型分布。在流行病学研究中，常用来拟合累积发病率或患病率的分布。

二项分布的概率函数为

$$
P (X) = \frac {n !}{X ! (n - X) !} \pi^ {X} (1 - \pi) ^ {n - X}
$$

式中P(X)为在含量n的样本中，出现阳性数为X的概率；$\pi$为总体中出现阳性结果的概率； $(1 - \pi)$ 为总体中阴性结果的概率，n为每次独立试验中的样本含量；X为样本含量为n的一次试验中出现的阳性数；n-X为同次试验出现的阴性数；!为阶乘。

在二项分布中，当n足够大，且 $n$ 不太靠近0或1时，如 $(n\geq 5$ 及 $n\geq 40)$，二项分布逼近正态分布，于是P(X)可用标准正态分布函数来描述，可按下式求得Z值。

$$
Z = - \frac {\left| X - n \pi \right| - 0 . 5}{\sqrt {n \pi} (1 - \pi)}
$$

二项分布的均数 $\mu$ ，方差 $\sigma^2$ 与标准差 $\sigma$ 分别按式(3)-(5)计算：

$$
\mu = \mathrm {n} \pi
$$

$$
\sigma^ {2} = \mathrm {n} \pi (1 - \pi)
$$

$$
\sigma = \sqrt {\mathrm {n} \pi (1 - \pi)}
$$

利用二项分布原理作统计推断，常用于：

总体率区间间的估计（1）查表法；当样本含量n较小，样本率p接近于o或1时，可通过查百分比 $95\%$ 可信区间表（附录四表10）来确定总体率 $95\%$ 的可信区间。

(2) 正态近似法：当n足够大，且样本率p和(1-p)均不太小，如np与n(1-p)均大于5时，可按下式求总体率的可信区间：

$$
\left(\mathrm {p} \pm Z _ {\alpha} \mathrm {s} _ {\mathrm {p}}\right)
$$

$Z_{\alpha}$ 为取 $\alpha$ 水准时的标准正态离差，求 $95\%$ 可信区间时，$Z_{0.05} = 1.96$；$s_{\mathrm{p}}$ 为率的标准误，

$$
s _ {p} = \sqrt {\frac {p (1 - p)}{n}}
$$

样本率与总体率比较 其目的是推断该样本所代表的知总体率 $\pi$ 与已知总体率 $m_0$ 是相差相同假设 $H_0: \pi = m_0;$ 备择假设 $H_1: \pi = m_0$. 当二项分布逼近正态分布时，可用Z检验（见“样本与总体比较”条）。另一种方法是直接计算概率法 即按前述的二项分布概率直接计算分布的尾部面积（见下例）。求出的尾部面积与与取单侧检验水准作比较，作推断。当 $\pi$ 偏离0.5较远，且阳性数X较小时，使用本法较为合适。

两样本率的比较（见“两组样本比较”条目中两样本率比较的Z检验）。

例 某胸科次生在一生产氯甲甲醚1.3收集到的14例肺癌

病人中，发现有12例的病理组织学类型是燕麦细胞癌。已知一般人群中燕麦细胞癌占全部肺癌的比例是 $10\% (\pi = 0.1)$。试问该厂的燕麦细胞癌是否比一般人群高，即燕麦细胞癌在该厂的分布是否具有聚集性？

14 例肺癌病人可看作是一组n个独立试验，如果每个试验结果有两种可能（+或一、有或无燕麦细胞癌），和已知每个试验阳性结果的概率，可用二项分布预测这即性结果的概率；如果小于所定的检水的水平，则可认为该样本的体率与已知的总体率是不同的。样本率比已知的总体率高，说明有聚集性。

$ \mathrm{H}_{2} $：该样本的总体率与已知总体率相等.

$ \mathrm{H}_{11} $两个总体率不相等。

因为问题是该厂的燕麦细胞癌是否比一般人群高，故作单侧检验。 $\alpha = 0.025$

单侧尾部面积为 $ \mathrm{P}(X=12),\mathrm{P}(X=13),\mathrm{P}(X=14) $三者之和.

$$
\begin{array}{l} P (1 2) = \frac {1 4 !}{1 2 ! (1 4 - 1 2) !} (0. 1) ^ {1 2} \times (0. 9) ^ {(1 4 - 1 2)} \\ = 7. 3 7 \times 1 2 \\ \end{array}
$$

$$
\begin{array}{l} \mathrm {当 X} \approx 1 3 \mathrm {时}, \mathrm {P} (1 3) = \frac {1 4 !}{1 3 ! \cdot (1 4 - 1 3) !} (0. 1) ^ {1 4} \times (0. 9) ^ {(1 4 - 1 3)} \\ = 1. 2 6 \times 1 0 ^ {- 1 2} \\ \end{array}
$$

$$
\begin{array}{l} \mathrm {当} X \sim 1 4 \text {时}, P (1 4) = \frac {1 4 t}{1 4 (1 4 - 1 4) !} (0. 1) ^ {1 4} \times (0. 9) ^ {1 4 - 1 4} \\ = 1 \times 1 0 ^ {- 1 4} \\ \end{array}
$$

$$
\begin{array}{l} P = P (1 2) + P (1 3) + P (1 4) = 7. 3 7 \times 1 0 ^ {1 1} + 1. 2 6 \times 1 0 ^ {1 2} \\ - 1 \times 1 0 ^ {- 1 4} = 7. 4 9 7 \times 1 0 ^ {1 1} \\ \end{array}
$$

核 $\alpha = 0.025$ 检水磷，拒绝 $\mathrm{H}_{2}$，接受 $\mathrm{H}_{3}$。可认为该厂燕麦细胞的比例比一般人高群，即燕麦细胞癌在该生产氯甲醚工厂具有聚集性，应该引起重视。

## ridit 检验

ridit检验(relative to an identified distribution unit)是用于比较等级数据样本的一种统计检验。在检验中，先要确定一个参照组的等级分布，根据这一分布确定出各个等级的参照单位(ridit，以R表示，值，并把各样本中每个以等级表示的观察值变换成R值，于是分别计算各对比样本平均R值 $(\bar{R})$ ，及其 $95\%$ 的可信区间（如规定 $\alpha = 0.05$）。从这个区间是否包括参照单位平均数（为固定值0.5），来作出判断；从中抽出这个样本的总体与参照总体是否等同。

作ridit分析时，必须选定一个参照组。最早的方法（Bross法）是在各对比组中取一个组，如把作为对照的组选为参照组。参照组的 $\overline{\mathbf{R}}$ 为0.5，R的方差为1/12（一般略小于1/12）。其他对比样本根据参照组提供的各等级参照单位值，分别计算各自的平均值 $\overline{\mathbf{R}}_{\mathrm{c}}$， $\mathrm{R}_{\mathrm{i}}$ 的方差 $\mathrm{o}_i^2$；

$$
\sigma_ {\mathrm {K l}} ^ {2} = 1 / \left(1 2 \mathrm {n} _ {\mathrm {l}}\right)
$$

$ \mathrm{n_{i}} $为i组样本的含量。

以后，对这最早规定的方法有所修正(Selvin)，如参照组的样本含量不大时，对Bross法的参照组是固定的这一看法有改变，将各对比组 $\bar{R}_i$ 的方差计算的式(2)代替式(1)：

$$
\sigma_ {\mathrm {R} 1} ^ {2} = \frac {1}{1 2} \mathrm {n} _ {0} + \frac {1}{1 2} \mathrm {n} _ {1} ^ {-}
$$

式中 $n_0$ 为参照组的样本含量。

如有两个样本作比较，用了一个共同的参照组（如另一个作为对照的组作为参照组），各计算出 $\overline{\mathrm{R}}_1$ 与 $\overline{\mathrm{R}}_2$ 值，由下式作Z检验：

$$
Z = \frac {\bar {R} _ {1}}{\sqrt {\sigma_ {\bar {R} _ {1} - \bar {R} _ {2}}}}
$$

$$
\sigma_ {R 1} ^ {\prime} - \bar {R} _ {2} = \frac {1}{1 2} \frac {1}{n _ {1}} + \frac {1}{1 2} \frac {1}{n _ {2}}
$$

$n_1, n_2$分别为两个对比样本的含量大小（由于用了共同参照组。$R_1$与 $R_2$ 为相关而有协变量，式（4）考虑了这个因素而使中无 $n_0$ 值）。

如有k个样本，平均ridit为 $ \mathrm{R}_{1}\dots \mathrm{R}_{k} $，检验它们是否从同一个总体中取出的样本，可作 $ x^{2} $检验：

$$
\chi^ {2} = 1 2 \left[ \sum_ {i = 1} ^ {k} n _ {i} \left(\bar {R} _ {1} - \bar {R}\right) ^ {2} + \frac {N n _ {0}}{N + n _ {0}} \left(\bar {R} - 0. 5\right) ^ {2} \right]
$$

自由度=k

上式中，N为1~k个样本含量总数，不包括对照组； $\overline{\mathrm{R}}$ 为1~k个样本的加权平均：

$$
\bar {\mathrm {R}} = \sum_ {i = 1} ^ {k} n _ {i} \bar {R} _ {i} / N
$$

式(5)又可分割成：$\textcircled{1}\chi_{1}^{2} = 12\left[\sum_{i=1}^{n}\left(\bar{R}_{i} - \dot{R}\right)^{2}\right]$，自由度 $= k - 1; \textcircled{2}\chi_{2}^{2} = 12 \frac{\mathrm{Nn}_{p}}{\mathrm{N} + n} (\bar{R} - 0.5)^{2}$，自由度为1。分别表示k个样本 $\bar{R}_{1}$ 偏离 $\bar{R}$ 和 $\bar{R}$ 偏离参照组均值0.5的 $\chi^{2}$值

分析步骤为：

(1) 选定参照组，从参照组各等级额数计算出各等级的R值。计算方法是，将一个等级频数的 $1 / 2$ 值，加到“移下一行的累计额数”中，再除以总例数 $n_0$，即得这一等级的R（参照）值。

参照组各个等级都应没有频数为0的值，如为大样本则更好。

(2) 从参照组得到的R值，按式（7）计算各对比组的平均R值：

$$
\bar {R} _ {i} = \frac {\sum f R}{n _ {i}}
$$

式中 $R$ 的平均R记为 $R_{i}$. $f$ 为这一组各个等级中出现的赖数，R为相应的参照单位值. $n_{i}$ 为这一组的样本含量，即 $\sum f$。

(3) 根据不同类型的比较，选用不同的检验方法；

样本与参照组比较：当参照组含量为 $n_0$ 时，用式(2)计算出样本 $\bar{R}$ 的方差 $\sigma_{10}^2$ 并用式(8)计算出 $95\%$ 可信限；

$$
\bar {R} _ {1} \pm 1. 9 6 \sigma_ {R _ {1}}
$$

如这一可信区间包括0.5，表示无显著差别。否则，有显著差别。

样本与样本之间比较；当两个样本选用同一个参照组时，可用式（3）、（4）作Z检验。

多组样本作比较而选用同一个参照组时，用式（5）、(6)作 $\chi^2$ 检验。

(4) 作图计算出各样本的 $\overline{R}$ 及可信区间。如某样本区组不与 $\overline{R} = 0.5$ 相交，则可认为与参照组有显著差别。

例1 对退休的樟工与非樟工各 55 名件肺部 X 线的检查.比较两组人肺部间质纤维化改变有无差别.肺部间质纤维化改变分为 I 一 V 级, I 为无变化.调查结果见表 1.问棉工与非棉工肺部间质纤维化改变有无差别?

<div align="center">

表1 热交换工与非热工部间质护维化改变

</div>

<table border="1"><tr><td>肺纤维化分级</td><td>棉工组</td><td>非棉工组</td></tr><tr><td>I</td><td>29</td><td>38</td></tr><tr><td>II</td><td>16</td><td>6</td></tr><tr><td>III</td><td>3</td><td>8</td></tr><tr><td>IV</td><td>6</td><td>3</td></tr><tr><td>V</td><td>1</td><td>0</td></tr><tr><td>合计人数</td><td>95</td><td>55</td></tr></table>

(1) 选定参照组。现两组人数一样，因为非棉工组在第V组中频数为0，不能计算出参照单位R，所以选棉工组为参照组，通过如表2的计算，得到各等级的R值。

<div align="center">

表2 从参阳组得各等级R值的计算

</div>

<table><tr><td>肺纤维化分级(1)</td><td>频数1(2)</td><td>(2)/2(3)</td><td>(2)各行累计并移下一行(4)</td><td>(3)+(4)(5)</td><td>(5)/n0(6)</td></tr><tr><td>I</td><td>29</td><td>14.5</td><td>0</td><td>14.5</td><td>0.264</td></tr><tr><td>II</td><td>16</td><td>8</td><td>29</td><td>37</td><td>0.673</td></tr><tr><td>III</td><td>3</td><td>1.5</td><td>45</td><td>46.5</td><td>0.845</td></tr><tr><td>IV</td><td>6</td><td>3</td><td>48</td><td>51</td><td>0.927</td></tr><tr><td>V</td><td>1</td><td>0.5</td><td>54</td><td>54.5</td><td>0.991</td></tr><tr><td>合计</td><td colspan="5">n0=55</td></tr></table>

(2) 从式（7）计算样本的平均参照单位值 $ \bar{R} $

$$
\begin{array}{l} \bar {R} _ {1} = \frac {\sum J R}{n _ {2}} \\ = (3 8 \times 0. 2 6 4 + 6 \times 0. 6 7 3 + 8 \times 0. 8 4 5 + 3 \times 0. 9 2 7) / 5 5 \\ = 2 3. 6 1 1 \div 5 5 = 0. 4 2 9. \\ \end{array}
$$

(3) 计算样本 $ \mathrm{R}_{1} $的 95%可信限：

从式（2），

$$
\sigma_ {k} ^ {2} = \frac {1}{1 2} n _ {0} - \pm \frac {1}{1 2} n _ {1} = \frac {1}{1 2 \times 5 5} + \frac {1}{1 2 \times 5 5} = 0. 0 5 5 ^ {2}
$$

从式（8），

$$
\begin{array}{l} R _ {1} \pm 1. 9 6 s _ {k} ^ {2} = 0. 4 2 9 \pm 1. 9 6 \times 0. 0 5 5 \\ - 0. 4 2 9 \neq 0. 1 0 8 \\ \end{array}
$$

可信区间为0.321一0.517，包括了0.5，因此表示样本均参照组无显著差别。

例2 对55名退休棉工和55名退休非棉工进一步调查吸姻习惯、得知如表3结果，问各组之间在肺纤维化程度上有否差别？

(1) 以有吸烟习惯的退休棉工组为参照组，得出等级的参照单位值如表4。

<div align="center">

表3 棉工和非棉工的排织维化汉文

</div>

<table><thead><tr><th rowspan="2">肺纤维化分级(1)</th><th colspan="2">棉工</th><th colspan="2">非棉工</th></tr><tr><th>吸烟(2)</th><th>不吸烟(3)</th><th>吸烟(4)</th><th>不吸烟(5)</th></tr></thead><tbody><tr><td>I</td><td>5</td><td>24</td><td>7</td><td>31</td></tr><tr><td>II</td><td>5</td><td>11</td><td>1</td><td>5</td></tr><tr><td>III</td><td>2</td><td>1</td><td>6</td><td>2</td></tr><tr><td>IV</td><td>5</td><td>1</td><td>3</td><td>0</td></tr><tr><td>V</td><td>1</td><td>0</td><td>0</td><td>0</td></tr><tr><td>n<sub>i</sub></td><td>n<sub>0</sub> = 18</td><td>37</td><td>17</td><td>38</td></tr></tbody></table>

<div align="center">

表4 从参照组得各等级R值

</div>

<table border="1"><tr><td>肺纤维化分级(1)</td><td>频数f(2)</td><td>(2)/2(3)</td><td>(2)各行累计并移下一行(4)</td><td>(3)-(4)(5)</td><td>(5)/n0(6)</td></tr><tr><td>I</td><td>5</td><td>2.5</td><td>0</td><td>2.5</td><td>0.139</td></tr><tr><td>II</td><td>5</td><td>2.5</td><td>5</td><td>7.5</td><td>0.417</td></tr><tr><td>III</td><td>2</td><td>1</td><td>10</td><td>11</td><td>0.611</td></tr><tr><td>IV</td><td>5</td><td>2.5</td><td>12</td><td>14.5</td><td>0.806</td></tr><tr><td>V</td><td>1</td><td>0.5</td><td>17</td><td>17.5</td><td>0.972</td></tr><tr><td>合计</td><td>n0-18</td><td></td><td></td><td></td><td></td></tr></table>

(2) 从式（7）计算出各组样本的 $ R $

棉工不吸烟组

$$
\begin{array}{l} \bar {R} _ {1} = (2 4 \times 0. 1 3 9 + 1 1 \times 0. 4 1 7 \\ + 1 \times 0. 6 1 1 + 1 \times 0. 8 0 6) / 3 7 \\ = 9. 3 4 / 3 7 = 0. 2 5 2 \\ \end{array}
$$

非棉工吸烟组

$$
\begin{array}{l} \mathrm {R} _ {2} = (7 \times 0. 1 3 9 + 1 \times 0. 1 1 7 \\ : 6 \times 0. 6 1 1 + 3 \times 0. 8 0 6) / 1 7 - 0. 4 4 0 \\ \end{array}
$$

非棉工.不吸烟组

$$
\begin{array}{l} \bar {R} _ {2} = (3 1 \times 0. 1 3 9 + 5 \times 0. 4 1 7 \\ + 2 \times 0. 6 1 1) / 3 8 = 0. 2 0 0 \\ \end{array}
$$

(3) 作 $ \chi^{2} $检验。按式(6)，计算 $ \bar{R}_{1},\bar{R}_{2},\bar{R}_{3} $的加权 $ \bar{R} $

$$
R = \sum n _ {i} R _ {i} / N = (3 7 \times 0. 2 5 2 + 1 7 \times 0. 4 4 0 + 3 8 \times 0. 2)
$$

按式（5）计算 $ x^{2} $值：

$$
\begin{array}{l} \chi^ {2} = 1 2 \left[ \sum n _ {1} \left(\bar {R} _ {1} - \bar {R}\right) ^ {2} + \frac {N n _ {0}}{N + n _ {e}} \left(\bar {R} - 0. 5\right) ^ {2} \right] \\ = 1 2 \left[ 3 7 (0. 2 5 2 0. 2 6 5) ^ {2} + 1 7 (0. 4 4 - 0. 2 6 5) ^ {2} \right. \\ + 3 8 (0. 2 - 0. 2 6 5) ^ {2} + \frac {9 2 \times 1 8}{9 2 + 1 8} (0. 2 6 5 - 0. 5) ^ {2} ] \\ = 1 2 \left[ 0. 0 0 6 2 5 + 0. 5 2 0 6 3 + 0. 1 6 0 5 5 - 0. 8 3 1 3 9 \right] \\ = 1 8. 2 2 5 \\ \end{array}
$$

自由度 $= 3$

查 $ \chi^{2} $表， $ \chi_{0.05,3}^{2}=3.182. $

结果表示4组样本(包括参照组)之间R值并非全部来自同一个总体。现进一步作 $x^2$ 分割：

$$
\chi_ {1} ^ {2} = 1 2 \sum n _ {i} \left(\bar {R} _ {i} - \bar {R}\right) ^ {2} - 1 2 \left(0 0 0 6 2 5 + 0. 5 2 0 6 3 - 0. 1 6 0 5 5\right)
$$

$$
1 = 3 - 1 = 2,
$$

$$
\chi_ {2} ^ {2} = 1 2 \frac {\mathrm {N} n _ {0}}{\mathrm {N} + \mathrm {n} _ {c}} - (\mathrm {R} - 0. 5) ^ {2} = 1 2 \times 0. 8 3 1 3 9 - 9. 9 7
$$

白山度=1，

查 $ \chi^{2} $'值表， $ \chi_{0.05,2}^{2}=5.99 $ $ \chi_{0.05,1}^{2}=3.84 $ ，因而， $ \chi^{2}>5.99 $ $ P^{2}>0.05 $ $ \chi_{0.05}^{2}\cdot 3.84 $ $ P<0.05 $

从 $R$ 表示参照组与其他三个组平均有显著差别。由于其他三个组的 $R$ 均小于0.5，说明参照组肺纤维化较严重，留下的其他三个组也有显著差别。以非棉工吸烟组为参照组继作 $x^{2}$ 检验，得 $R_{1}$ 分别为0.307（非棉工不吸烟）、0.260（非棉工不吸烟）、$R_{2}$ （两个不吸烟组平均）-0.283。得

$$
x _ {i} ^ {2} = - 2. 8 4, \text {自 由 度} = 1, x _ {i} ^ {2} < x _ {0 0 5, 1} ^ {2} P > 0. 0 5
$$

$$
\chi_ {2} ^ {2} = 7. 8 3, \mathrm {自 由 度} = 1, \chi_ {2} ^ {2} < \chi_ {\mathrm {n o s}, 1} ^ {2}, P < 0. 0 5
$$

从 $2^{\circ} \mathrm{C}$ 表示参照组（非棉工吸烟组）与两个不吸烟组的平均有显著差别，对值则表示两个不吸烟组 $R_{\mathrm{i}}$ 与它们的平均R间无显著不同。

## 分析结果说明吸姻组与不吸姻组在肺纤维化上有显著不同

(4) 图示方法，现以舵「吸烟组为参照组，观察其他三个组与参照组有否显著差别，用式(2)计算出各组 $R$ 的方差，再计算可信值。结果如下：

<table><tr><td>组别</td><td>R1</td><td>σk1=</td><td>√1/12n0+1/12n1</td><td>R1±1.96 σk1</td></tr><tr><td>桶工,不吸烟</td><td>0.252</td><td>0.083</td><td></td><td>0.089-0.414</td></tr><tr><td>非桶工,吸烟</td><td>0.440</td><td>0.098</td><td></td><td>0.248-0.632</td></tr><tr><td>非桶工,不吸烟</td><td>0.200</td><td>0.083</td><td></td><td>0.138-0.363</td></tr></table>

上列数据制成图。可见棉工不吸烟组与非棉工吸烟组与参照组有显著差别（图）。

![](page=5,bbox=[516, 728, 796, 1003])

<div align="center">

以棉工吸烟组为参照组显示两个不吸烟组与参照组有区别

</div>

<div align="center">

# 参数估计

</div>

## 参数估计

统计上常用参数来描述总体的特征，如用总体均数、中位数和众位数等来描述总体的中心位置或集中趋势，用总体标准差、极差和四分位数间距等来描述总体的离散度。但总体参数常属未知，需进行参数估计，也就是用样本统计量来估计总体参数（包括其估计误差）。参数估计（parameter estimation）和假设检验是统计推断的两个重要领域。

参数估计分为点估计和区间估计。点估计是给出被估计参数一个适当的估计值，区间估计是给出被估计可能的数值范围。如抽样调查某地7岁男孩身高，得样本均数 $119.1\mathrm{cm}$，以此作为该地7岁男孩身高总体均数的估计值，这是点估计。若提出该地7岁男孩身高总体均数的 $95\%$ 可信区间为 $118.3-119.3\mathrm{cm}$，这是区间估计。在科技报告中，点估计与区间估计常同时写出，如本例可写成： $119.1\mathrm{cm}(118.3,119.9\mathrm{cm})$ 。用点估计时，为了说明估计的精度，常同时写明标准误。

## 点估计

参数的点估计(point estimation)是根据样本值对总体参数作定值估计。例如，设 $X_{1}, X_{2}, \dots X_{n}$ 是从总体中抽取的容量为 $n$ 的样本，样本均数与样本方差分别为

$$
\begin{array}{l} \bar {X} = \frac {1}{n} \sum_ {i = 1} ^ {n} X _ {i} \\ s ^ {2} = \frac {1}{(n - 1)} \sum_ {i = 1} ^ {n} \left(X _ {i} - \bar {X}\right) ^ {2} \\ \end{array}
$$

一般设总体分布函数 $\mathrm{F}(\mathrm{X}_1\theta_1\theta_2\dots \theta_k)$，用k个样本参数 $\hat{\theta}_i = \hat{\theta}_i(\mathrm{X}_1\mathrm{X}_2\dots \mathrm{X}_n)$分别去估计k个参数 $\theta_{iv}i = 1,2\dots k$，称 $\hat{\theta}_i$为 $\theta_i$ 的估计量（estimator）。估计量是用于估计参数的统计量。对于每一个观测样本，有一个相应的值，称为参数的估计值（estimate）。

这种用 $\hat{\theta}_1$ 对参数 $\theta_{1}$ 作的定值估计，称为参数的点估计。

## 区间估计

参数的区间估计(interval estimation of parameter)是从样本的观察值对总体的未知参数值的可能范围作出估计，也即对未知参数估计定出一个区间，使参数值按指定的概率包含在这个区间内。

例如，已知总体呈正态分布， $\sigma = 10$ ，而不知其均数 $\mu$ 。从这总体中抽取含量n=25的样本，其平均数X为50，可对总体均数 $\mu$ 作一区间估计：

$$
(\bar {X} - Z _ {a} \frac {\sigma}{\sqrt {n}}, \bar {X} + Z _ {a} \frac {\sigma}{\sqrt {n}})
$$

以 $\bar{X} = 50, \sigma = 10, n = 25, \alpha = 0.05, Z_{\alpha} = 1.96$ 代入得：46.08-53.92。总体均数在这范围之内。

所估计的区间，称为可信区间，当 $\alpha = 0.05$ 时，称为 $95\%$ 可信区间，$95\%$ 为 $1 - \alpha$ 值。这一区间的上下两个数值，称为可信限（confidence limit）。通常计算 $95\%$ 可信区间。当要求得到 $99\%$ 的可信区间时，则 $1 - \alpha = 0.99$，$\alpha$ 取0.01。$1 - \alpha$称为可信度或可信概率（confidence probability）。当 $1 - \alpha$ 取 $95\%$ 时，表示从样本而得的可信区间，有 $95\%$ 的概率包含总体的参数。也就是说，从被估计的总体中随机抽取含量为n的样本，由每个样本计算出一个 $95\%$ 可信区间，有 $95\%$ 可信区间将包含被估计的参数值，而 $5\%$ 将不包括。所以 $1 - \alpha$ 取值越高，如取 $99\%$，所得区间更为可信。

## 矩估计

矩(moment)是随机变量X或X与期望值E(X)之差(X-E(X))的幂函数的教学期望。X的k次幂的数学期望E(X*)称为X的k阶原点矩，X-E(X))k次幂的数学期望E(X-E(X))*称为X的k阶中心矩。X的一阶原点矩E(X)就是总体的均数，X的二阶中心矩E(X-E(X))²就是总体的方差。矩估计法(moment method of estimation)就是用样本矩来估计相应的总体矩，或根据参数与矩的函数关系来估计参数的方法。

设一总体的分布为 $F(X_{1},\theta_{1},\theta_{2}\dots \theta_{p})$ ，X为变量， $\theta_{1}\dots$

$\theta_{4}$ 为p个参数。样本的 $i$ 阶原点矩为 $m_{i}$，中心矩为 $\mu_{i}$，相应的总体矩记为 $E(\mathbf{X}) = M_{1}(\theta_{1}, \theta_{2}, \dots, \theta_{p})$ 与 $E\{(X - E(\mathbf{X}))\} = \theta_{1}(\theta_{2}, \dots, \theta_{p})$， $m_{i}$ 可作为 $M_{i}$ 的估计值。

总体分布中的参数不一定就是矩本身。当分布为已知时，就可知原点矩、中心矩与参数的函数关系。样本矩可从样本变量值得到，以样本矩代替总体矩，得p个方程组，即 $i = 1\dots p$

$$
\begin{array}{l} m _ {i} = M _ {i} \left(\theta_ {1}, \theta_ {2} \dots \theta_ {p}\right) \\ \text {或} \mu_ {i} = U _ {i} \left(\theta_ {1}, \theta_ {2} \dots \theta_ {p}\right) \\ \end{array}
$$

从p个方程得p个未知参数估计值。

由n个测值的样本 $X_{1} \dots X_{n}$，得自呈指数分布的总体。指数分布的参数为 $\lambda$，指数分布的密度函数为：

$$
\mathrm {f} (\mathrm {X}) = \left\{ \begin{array}{l l} \lambda \mathrm {e} ^ {- \lambda x}, & \text {当} \mathrm {X} > 0 \\ 0, & \mathrm {X} \leqslant 0 \end{array} \right.
$$

变量X的期望值为

$$
\mathrm {E} (X) = \frac {1}{\lambda}
$$

因样本的一阶原点矩为 $\overline{X}$ 。根据式（3），可从样本 $X$ 得 $\lambda$ 的估计量；

$$
\hat {\lambda} = \frac {1}{\bar {X}}
$$

设变量 $\mathrm{X}_{\mathrm{i}},\dots ,\mathrm{X}_{\mathrm{n}}$ 为从总体X的随机样本。X服从 $\Gamma$分布。 $\Gamma$ 分布有 $\alpha ,\beta$ 两个参数，这分布的·阶期望值和方差分别为：

$$
\begin{array}{l} \mathrm {E} (\mathrm {X}) = \beta (\alpha + 1) \\ \mathrm {D} (\mathrm {X}) = \beta^ {2} (\alpha + 1) \\ \end{array}
$$

从 $X_{1}\dots X_{n}$ 样本测值可以估计 $\alpha ,\beta$ 。

样本的一阶原点矩和二阶中心矩分别为 $\overline{\mathbf{X}}$ 与 $\mathrm{s}^2$ 。根据式(1)得

$$
\left\{ \begin{array}{l} \bar {X} = \hat {\beta} (\hat {\alpha} + 1) \\ s ^ {2} = \hat {\beta} ^ {2} (\hat {\alpha} + 1) \end{array} \right.
$$

解上联立方程式，得

$$
\hat {\alpha} = \frac {\bar {X} ^ {2}}{s ^ {2}} - 1
$$

$$
\hat {\beta} = \frac {s ^ {2}}{\bar {X}}
$$

从上两公式得到 $\hat{\alpha},\hat{\beta}$ ，即为 $\alpha ,\beta$ 两个参数的估计量。

## 最大似然估计法

最大似然估计法(maximum likelihood method of estimation)又称极大似然估计法，是对一已发生的事件（即具体样本），认为其发生的概率应该最大，所以当分布类型已知时，就可以从样本观测值写出概率计算式（又称最大似然函数），从而计算出使该概率为最大时的参数估计值的估计法。

设有一分布 $P(\mathrm{X};\theta_{1},\theta_{2}\dots \theta_{k})$ ，其中 $\theta_{1},\theta_{2}\dots \theta_{k}$ 为k个

未知参数，取一样本值为 $ \mathrm{X}_{1}\mathrm{X}_{2}\cdots\mathrm{X}_{n} $的概率为：

$$
\begin{array}{l} \mathrm {P} \left(\mathrm {X} = \mathrm {X} _ {1}\right) \mathrm {P} \left(\mathrm {X} = \mathrm {X} _ {2}\right) \dots \mathrm {P} \left(\mathrm {X} = \mathrm {X} _ {n}\right) = \prod_ {i = 1} ^ {n} \mathrm {P} \left(\mathrm {X} _ {i}; \theta_ {1}, \theta_ {2} \dots \theta_ {k}\right) \\ \mathrm {i t} \mathrm {L} = \mathrm {L} \left(\mathrm {X} _ {1}, \mathrm {X} _ {2} \dots \mathrm {X} _ {n 1} \theta_ {1}, \theta_ {2} \dots \theta_ {k}\right) \\ = \prod_ {i = 1} ^ {n} \mathrm {P} \left(\mathrm {X} _ {i}; \theta_ {1}, \theta_ {2} \dots \theta_ {k}\right) \tag {1} \\ \end{array}
$$

当参数 $ \theta_{1},\theta_{2}\dots \theta_{k} $满足

$$
\begin{array}{l} \frac {\partial L}{\partial \theta_ {j}} = - \frac {\partial}{\partial \theta_ {j}} L \left(X _ {1}, X _ {2} \dots X _ {n}, \theta_ {1}, \theta_ {2} \dots \theta_ {n}\right) = 0 \\ j = 1, 2, \dots k \\ \end{array}
$$

或

$$
\begin{array}{l} \frac {\partial \ln L}{\partial \theta_ {j}} = \frac {\partial}{\partial \theta_ {j}} \ln L \left(X _ {1}, X _ {2} \dots X _ {n}; \theta_ {1}, \theta_ {2} \dots \theta_ {k}\right) = 0 \\ j = 1, 2 \dots k \\ \end{array}
$$

时，概率 $\prod_{i=1}^{n} P\left(X_{1}, \theta_{1}, \theta_{2} \dots \theta_{k}\right)$ 最大。由 $\frac{\partial L}{\partial \theta_{1}} = 0$ 或 $\frac{\partial \ln L}{\partial \theta_{1}} = 0, j = 1, 2 \dots k,$ 解出的 $\hat{\theta}_{j} = \hat{\theta}_{j}\left(X_{1}, X_{2}, \dots, X_{n}\right)$ 就称为相应参数 $\theta_{j}$ 的最大似然估计，L称为似然函数，lnL称为对数似然函数。

例1 从Poisson分布 $P(X_{t} \lambda)$ 中输出样本 $X_{t} \dots X_{n}$，求出参数 $\lambda$ 的最大似然估计。

因Poisson分布 $P(\mathrm{X};\lambda) = \frac{\lambda e^{-\lambda}}{X!}$，样本值为 $X_{1}\dots X_{n}$ 时似然函数与对数似然函数为：

$$
L = \frac {\lambda}{\prod_ {i = 1} ^ {n}} \frac {e ^ {- n i}}{\left(X _ {i !}\right)}
$$

$$
\ln L = \sum_ {i = 1} ^ {n} X _ {i} \ln \lambda - n \lambda - \sum_ {i = 1} ^ {n} \ln \left(X _ {i:}\right)
$$

所以由

$$
\frac {\partial \ln L}{\partial \lambda} = 0
$$

解得

$$
\hat {\lambda} = \frac {1}{n} \sum_ {i = 1} ^ {n} X _ {i} = \dot {X}
$$

即Poisson分布参数 $k$ 的最大似然估计为样本均数.

例2 从正态分布 $f(X; \mu, \sigma^2) = \frac{1}{\sqrt{2}\pi}\sigma^2 \mathrm{e}^{\frac{X^2}{2\sigma^2} - \frac{(\mu)^2}{2\sigma^2}}$ 中抽出随机样本 $X_{1} \dots X_{n}$。求参数 $\mu$ 与 $\sigma^2$ 的最大似然估计。

正态分布的似然函数与对数似然函数分别为

$$
\mathrm {L} = \left(\frac {1}{\sqrt {2} \pi \sigma}\right) ^ {n} \mathrm {e} ^ {\frac {1}{2} \frac {\sigma}{d ^ {2}}} \sum_ {i = 1} ^ {n} \left(X _ {i} - \mu\right) ^ {2}
$$

$$
\ln L = - \ln (\sqrt {2} \pi) ^ {n} - \frac {n}{2} \ln \sigma^ {2} - \frac {1}{2} \frac {1}{\sigma^ {2}} \sum_ {i = 1} ^ {n} \left(X _ {i} - \mu\right) ^ {2}
$$

所以由

$$
\left\{ \begin{array}{l} \frac {\partial \ln L}{\partial \mu} = \frac {1}{\sigma^ {2}} \sum_ {i = 1} ^ {n} \left(X _ {i} - \mu\right) = 0 \\ \frac {\partial \ln L}{\partial \sigma^ {2}} = - \frac {n}{2} \frac {\mathrm {n}}{\sigma^ {2}} + \frac {1}{2 \left(\sigma^ {2}\right) ^ {2}} \sum_ {i = 1} ^ {n} \left(X _ {i} - \mu\right) ^ {2} = 0 \end{array} \right.
$$

解得

$$
\left\{ \begin{array}{l} \hat {\mu} = \frac {1}{n} \sum_ {i = 1} ^ {n} X _ {i} = \bar {X} \\ \hat {\sigma} ^ {2} = \frac {1}{n} \sum_ {i = 1} ^ {n} \left(X _ {i} \cdot X\right) ^ {2} = s ^ {2}. \end{array} \right.
$$

即正态分布 $N(\mu ,\sigma^ {2})$ 中，参数 $\mu$ 与 $\sigma^ {2}$ 的最大似然估计与矩估计

相同。

## 最小二乘法

最小二乘法(least square method)是一种参数估计方法，常用于回归方程式的参数估计。这一方法的基本原理是使从回归方程式算得的估计值 $\hat{Y}$ 与实际观测值 $Y$ 的离差平方和 $\sum (\mathrm{Y} - \hat{Y})^2$ 达最小。

设两个变量X，Y的关系为

$\mathrm{Y} = \alpha + \beta \mathrm{X} + \varepsilon$ ，其中 $\varepsilon$ 是随机变量， $\alpha ,\beta$ 是参数。相应的直线回归方程式为

$$
\hat {Y} = a + b X
$$

其中a与b分别是参数 $\alpha$ 与 $\beta$ 的估计，如何由样本 $(\mathrm{X}_1, \mathrm{Y}_1)$ $\dots (\mathrm{X}_n, \mathrm{Y}_n)$ 求得a与b，可用最小二乘法，即使a与b满足以下条件：

$$
\begin{array}{l} Q = \sum \left(Y - \hat {Y} _ {1}\right) ^ {2} = \left(Y _ {1} - \hat {Y} _ {1}\right) ^ {2} + \left(Y _ {2} - \hat {Y} _ {2}\right) ^ {2} + \dots \\ + \left(Y _ {n} - \hat {Y} _ {n}\right) ^ {2} \\ = \left[ Y _ {1} - \left(a + b X _ {1}\right) \right] ^ {2} + \left[ Y _ {2} - \left(a + b X _ {2}\right) \right] ^ {2} + \dots \\ + \left[ Y _ {n} - \left(a + b X _ {n}\right) \right] ^ {2} \\ \end{array}
$$

达最小。由微积分学，a与b必满足以下方程组：

$$
\left\{ \begin{array}{l} \frac {\partial Q}{\partial a} = 0 \\ \frac {\partial Q}{\partial b} = 0 \end{array} \right.
$$

即方程组

$$
\left\{ \begin{array}{l} \mathrm {n a} + b \sum X = \sum Y \\ a \sum X + b \sum X ^ {2} = \sum X Y \end{array} \right.
$$

解上述方程组得到

$$
b = \frac {\sum X Y - (\sum X) (\sum Y) / n}{\sum X ^ {2} - (\sum X) ^ {2} / n}
$$

$$
a = \bar {Y} - b \bar {X}
$$

所以用最小二乘法求回归方程 $\bar{Y} = a + bX$ 中a与b，只要先求 $\sum X, \sum Y, \sum X^2, \sum XY$，然后代入式(1)和式(2)(具体例子见“直线回归”条)。

## 贝叶斯估计法

贝叶斯估计法(Bayes method of estimation)是除了利用样本提供的信息外，还结合以前经验的信息来作参数估计的方法。这与矩法和最大似然估计法不同，后两者只是用样本提供的信息来对参数作出估计。在估计中利用已有的经验信息有可能得到更有实际意义的估计值，但此法的处理步骤较矩法和最大似然法稍复杂。

贝叶斯估计法把所求的参数在可能出现的范围中视作变量，其分布称为先验分布，以h(θ)表示，由先验信息所提供，以f(x/θ)表示在参数取值 $\theta$ 条件下总体X的条件分布，并设 $\theta$ 在出现样本值 $X$ 的条件下条件为g($\theta /x$)，则根据贝叶斯定理，从h(θ)、f(x/θ)可得g($\theta /x$)。

有了 $g(\theta /\mathrm{x})$ 后，再采用其他的参数估计方法，得到参数 $\theta$ 的贝叶斯估计量。其步骤如下：

1. 由样本 $ \mathrm{x}_{1},\mathrm{x}_{2}\dots \mathrm{x}_{n} $确定 $ \mathrm{f(x / \theta)}。 $

2. 确定先验分布 $ \mathrm{h}(\theta)_{a} $

3. 根据贝叶斯定理，构成 $ \mathrm{g} \left( \theta / \mathrm{x} \right) $ ，它有下列几种形式：

(1) $ \theta $ 、x都是离散型时，

$$
g (\theta / x) = \frac {h (\theta) f \left(x / \theta\right)}{\sum_ {\theta} h (\theta) \overline {{f \left(x / \theta\right)}}}
$$

g、h、f表示概率分布。

(2) $ \theta $为离散型，x为连续型时，

$$
g (\theta / x) = \frac {h (\theta) f \left(x / \theta\right)}{\sum_ {\theta} h (\theta) f \left(x / \theta\right)}
$$

g、h表示概率分布，f表示概率密度。

(3) $ \theta $为连续型，X为离散型时.

$$
g (\theta / x) = \frac {h (\theta) f \left(x / \theta\right)}{f _ {-} g h (\theta) f \left(x / \theta\right) d \theta}
$$

g. h为概率密度，f为概率分布。

(4) $ \theta, x $都是连续型时，

$$
g (\theta / x) = \frac {\mathrm {h} (\theta) \mathrm {f} \left(\mathrm {x} / \theta\right)}{f _ {-} \mathrm {h} (\theta) \mathrm {f} \left(\mathrm {x} / \theta\right) \mathrm {d} \theta}
$$

g,h,f表示概率密度。

4. 再按矩法从 $ \mathrm{g} (\theta /\mathrm{x}) $得到参数 $ \theta $的贝叶斯估计量。

$$
\hat {\theta} = \mathrm {E} (\theta / \mathrm {x}) = \left\{ \begin{array}{l l} \sum_ {\theta} \theta \mathrm {g} (\theta / \mathrm {x}) & \theta \text {为 离 散 型} \\ \int_ {- \infty} ^ {\infty} \theta \mathrm {g} (\theta / \mathrm {x}) \mathrm {d} \theta & \theta \text {为 连 续 型} \end{array} \right.
$$

这样得到的估计都称贝叶斯估计。

例 在HBsAg阳性率为P的人群中取一个容量为 $n\pm 250$ 的样本.发现有5人HBsAg阳性，试用贝叶斯方法估计阳性率 $P_{0}$

(1) 

$$
\text {记} x = \sum_ {i = 1} ^ {n} x _ {i} \text {这 时 因} P \left(x _ {i}\right) = \left\{ \begin{array}{l l} p, & x _ {i} = 1 \\ 1 - p, & x _ {i} = 0 \end{array} \right.
$$

$$
f (x / p) = C _ {n} ^ {x} p ^ {x} (1 - p) ^ {n x}
$$

$$
(2) \text {假 定} h (p) = \left\{ \begin{array}{l l} 1, 0 \leqslant p \leqslant 1 \\ 0, p < 0, p > 1 \end{array} \right.
$$

(3) P为连续型，x为离散型，用式(3)得

$$
g (p / x) = \frac {- C _ {1} ^ {n} p ^ {x} (1 - p) ^ {n - x}}{\int_ {0} ^ {1} C _ {2} ^ {n} x ^ {2} (1 - p) ^ {n - x} d p} - \frac {P ^ {x} (1 - p) ^ {n x}}{\int_ {0} ^ {1} P ^ {x} (1 - p) ^ {n - x} d p}
$$

(4) 从g（p/x）得到估计值。可用矩法或最大似然法。

$$
\hat {p} = \int_ {0} ^ {1} p ^ {- 1} \int_ {0} ^ {1} \frac {p ^ {x} (1 - p) ^ {n - x}}{p ^ {2} (1 - p) ^ {n} x} d p - d p = \frac {x + 1}{n + 2} = \frac {6}{2 5 2} = 0. 0 2 3 8
$$

此式的特点是当 $r = 0$ 时，得到的阳性率估计值 $p$ 不等于0.

在样本p出现0值而理论上不为0时，贝叶斯估计较好合理。

## 估计量的评价准则

估计量的评价准则(measures of quality of an

estimator)是用来判断由不同方法得到的总体参数估计是否为优的标准，主要考核估计量是否满足下列三个要求：一致性、无偏性和有效性。

设总体 $X$ 的概率函数为 $f(\mathrm{X}_1;\theta),\mathrm{X}_1,\mathrm{X}_2\dots \mathrm{Xn}$ 为从中抽取的一个样本， $\hat{\theta} = \hat{\theta} (\mathrm{X}_1,\mathrm{X}_2\dots \mathrm{Xn})$ 为参数 $\theta$ 的估计。

估计量的一致性是分析样本增大时估计所具有的性质。显然，当样本容量 $n$ 越大时，估计 $\theta$ 接近参数 $\theta$ 的概率越大就理想，即对任意正数 $\epsilon > 0$，要求有

$$
\lim _ {n \rightarrow \infty} \mathrm {P} (| \hat {\theta} - \theta | < \varepsilon) = 1
$$

当上式成立时，称 $\hat{\theta}$ 是 $\theta$ 的一致估计或相合估计，或说估计 $\hat{\theta}$ 具有一致性。总体分布的各阶原点矩和中心矩与样本的矩相同，因而均数和方差的矩法估计 $\hat{E}(\mathrm{X}) = \bar{X}$ 与 $\hat{D}(\mathrm{X}) = s^2$ 具有一致性。

无偏估计 若参数 $ \theta $的估计 $ \hat{\theta} $满足

$$
\mathrm {E} (\hat {\theta}) = \theta
$$

则称 $\hat{\theta}$ 是 $\theta$ 的无偏估计，并说估计 $\hat{\theta}$ 具有无偏性。

如果 $\mathrm{E}(\hat{\theta}) \neq \theta$ ，则说 $\hat{\theta}$ 是有偏的，并称 $\mathrm{E}(\hat{\theta}) - \theta$ 是估计 $\hat{\theta}$ 的偏差。这时若

$$
\lim _ {n \rightarrow \infty} \mathrm {E} (\hat {\theta}) = \theta
$$

则称 $ \hat{\theta} $是 $ \theta $的渐近无偏估计。

有效估计 当参数 $\theta$ 的估计 $\hat{\theta}$ 为无偏并且有多个时，显然，无偏估计以 $\theta$ 的方差小为理想。其中使方差 $D(\hat{\theta}) = E[(\hat{\theta} - \theta)^2]$ 为最小的哪个 $\hat{\theta}$ 就较其他的估计有效。如 $\hat{\theta}_1, \hat{\theta}_2$ 都是参数 $\theta$ 的无偏估计，若方差 $D(\hat{\theta}_1) < D(\hat{\theta}_2)$，则称估计 $\hat{\theta}_1$ 比 $\hat{\theta}_2$ 有效。

## 正态总体参数估计

若总体X服从正态分布 $N(\mu ,\sigma^2)$，则分布由其均数 $\mu$ 和方差 $\sigma^2$ 确定。正态体参数估计(estimation of the parameters in a normal distribution)就是根据样本观测值对总体均数 $\mu$ 和总体方差 $\sigma^2$ 进行估计。

## 正态总体均数 $ \mu $的估计

点估计 正态总体均数 $\mu$ 在矩法估计和最大似然法估计都是X。

区间估计 有以下两种。

(1) $\sigma^2$ 已知时 $\mu$ 的区间估计：$\mu$ 的 $95\%$ 可信区间为 $(\bar{X} - 1.96\frac{\sigma}{\sqrt{n}}, \bar{X} + 1.96\frac{\sigma}{\sqrt{n}})$。一般若 $P\left(\frac{\left| \bar{X} - \mu \right|}{\sigma \sqrt{n}} < Z_a\right)$

$= 1 - \alpha$ ，则 $\mu$ 的 $1 - \alpha$ 可信区间为 $\left(\bar{X} - Z_a\frac{\sigma}{\sqrt{n}}, \bar{X} + Z_a\right.$ $\frac{\sigma}{\sqrt{n}})$。

(2) $\sigma^2$ 未知时 $\mu$ 的区间估计：当 $\sigma^2$ 未知时，记 $s^2 = \frac{1}{n - 1}\sum_{i = 1}^{n}(X_i - \bar{X})^2$ 。因为 $t = \frac{\bar{X} - \mu}{s / \sqrt{n}}$ 服从 $n - 1$ 个自由度

的 $t$ 分布，所以由 $P\left(\frac{\left| \overline{X} - \mu \right|}{s / \sqrt{n}} < t_{\alpha (n)}\right) = 1 - \alpha$ ，得 $\mu$ 的 $1 - \alpha$ 可信区间为

$$
\left(\bar {X} - t _ {\alpha , (n - 1)} \frac {s}{\sqrt {n}}, \bar {X} + t _ {\alpha , (n - 1)} \frac {s}{\sqrt {n}}\right)
$$

例1 某厂对6名喷漆女工测其收缩压，得样本均数 $X = 15.24\mathrm{kPa}$，样本标准差 $s = 1.41\mathrm{kPa}$，假定收缩压服从正态分布 $N(\mu, \sigma^2)$，求其均数 $\mu$ 的 $95\%$ 可信区间。

因 $\sigma^2$ 未知，$S_x = \frac{\sqrt{s}}{n} = 0.58\mathrm{kPa}$. 由 $t$ 分布表查得 $t_{0.05(1)} = 2.571$. 所以该 $H_{擦女工}$ 擦女压均数的 $95\%$ 可信区间为 $(15.21-2.571\times 0.58, 12.271\times 0.58)$. 即为 $(13.72, 16.70)$.

两个正态总体均数差的区间估计

记 $\bar{x} = \frac{1}{n_1} \sum_{i=1}^{n_1} x_{i_1}, \bar{y} = \frac{1}{n_2} \sum_{i=1}^{n_2} y_{i_1}; s_1^2 = \frac{1}{n_1 - 1} \sum_{i=1}^{n_1} (x_1 - \bar{x})^2$ $s_2^2 = \frac{1}{n_2} \cdot \frac{1}{n_1} \sum_{i=1}^{n_1} (y_1 - \bar{y})^2$ 分别表示两个正态总体 $N(\mu_1, \sigma_1^2)$ 和 $N(\mu_2, \sigma_2^2)$ 的样本均数和方差。因为在方差 $\sigma_1^2, \sigma_2^2$ 已知时，统计量

$$
Z - \frac {\left(\vec {x} - \vec {y}\right) - \left(\mu_ {1} - \mu_ {2}\right)}{\sqrt {\frac {\sigma_ {1} ^ {2}}{n _ {1}} + \frac {\sigma_ {2} ^ {2}}{n _ {2}}}}
$$

服从标准正态分布N（0,1）；在方差未知但相等（ $\sigma_1^2 =$ $\sigma_2^2 = \sigma^2$ ）时，统计量

$$
t _ {\left(n _ {1} + n _ {2} - 2\right)} = - \sqrt {\frac {\left(\bar {x} - \bar {y}\right) - \left(\mu_ {1} - \mu_ {2}\right)}{\frac {\left(n _ {1} - 1\right) s _ {1} ^ {2} + \left(n _ {2} - 1\right) s _ {2} ^ {2}}{n _ {1} + n _ {2} - 2}} \left(\frac {1}{n _ {1}} + \frac {1}{n _ {2}}\right)}
$$

展从 $n_1 + n_2 = 2$ 个自由度的分布。所以当方差已知时，数差 $\mu_1 - \mu_2$ 的 $1 - \alpha$ 可信区间为

$$

\left(\left(\bar {x} - \bar {y}\right) - Z _ {\alpha} \sqrt {\frac {\sigma_ {1} ^ {2}}{n _ {1}} + \frac {\sigma_ {2} ^ {2}}{n _ {2}}}, \left(\bar {x} - \bar {y}\right) + Z _ {\alpha} \sqrt {\frac {\sigma_ {1} ^ {2}}{n _ {1}} + \frac {\sigma_ {2} ^ {2}}{n _ {2}}}\right)

$$

当方差未知但相等时，均数差 $\mu_1 - \mu_2$ 的 $1 - \alpha$ 可信区间为

$$

\left(\left(\bar {x} - \bar {y}\right) - t _ {\alpha \left(n _ {1} + n _ {2} - 2\right)} s _ {\bar {x} - \bar {y}}, \left(x - \bar {y}\right) + t _ {\alpha \left(n _ {1} + n _ {2} - 2\right)} s _ {x - y}\right)

$$

其中

$$

s _ {\bar {x}} \bar {y} = \sqrt {\frac {\left(n _ {1} - 1\right) s _ {n _ {1}} ^ {2} + \left(n _ {2} - 1\right) s _ {n _ {2}} ^ {2}}{n _ {1} + n _ {2} - 2}} \left(\frac {1}{n _ {1}} + \frac {1}{n _ {2}}\right)

$$

$$
s _ {\bar {x}} \bar {y} = \sqrt {\frac {\left(n _ {1} - 1\right) s _ {1} ^ {2} + \left(n _ {2} - 1\right) s _ {2} ^ {2}}{n _ {1} + n _ {2} - 2}} \left(\frac {1}{n _ {1}} + \frac {1}{n _ {2}}\right)
$$

当可信区间包含零点时，可认为两均数在 $ \alpha $显著性水平上差别不显著。

## 正态总体方差 $ \sigma^{2} $的估计

点估计 由 $C_{3,4,\beta}$ 知， $s^2 = \frac{1}{n - 1}\sum_{i = 1}^{n}\left(X_{i} - \bar{X}\right)^{2}$ ，或当 $\mu$ 已知时 $\sigma_ {n} ^ {2} = \frac{1}{n}\sum_{i = 1}^{n}\left(X_{i} - \mu\right)^{2}$ 是正态总体方差 $\sigma^2$ 的无偏估计。

区间估计 有以下两种。

(1) $\mu$ 已知时 $\sigma^2$ 的区间估计：当 $\mu$ 已知时，$\chi_1^2 = \frac{\mathrm{n}\sigma_1^2}{\sigma^2} = \frac{1}{\sigma^2} \sum_{i=1}^{n} (X_1 - \mu)^2$ 服从 $n$ 个自由度的 $\chi^2$ 分布，所以可由 $P(\chi^2(\alpha \frac{\alpha}{2}) < \chi_1^2 < \chi^2(\frac{\alpha}{2}, n)) = 1 - \alpha$ 得出 $\sigma^2$ 的 $1 - \alpha$ 可信

区间为

$$
\left(\frac {\sum_ {i = 1} ^ {n} \left(X _ {i} - \mu\right) ^ {2}}{\chi_ {i} ^ {2} n}, \frac {\sum_ {i = 1} ^ {n} \left(X _ {i} - \mu\right) ^ {2}}{\chi_ {i} ^ {2} \left(1 - \frac {\alpha}{2}\right) n}\right)
$$

(2) $\mu$ 未知时 $\sigma^2$ 的区间估计：当 $\mu$ 未知时， $\chi_ {(n - 1)}^2 = \frac {(n - 1) s^2}{\sigma^2}$ 服从 $n - 1$ 个自由度的 $\chi^2$ 分布，所以可由P $(\chi_ {(n - \frac {2}{2})} ^ {2} (n - 1) < \chi_ {(n - 1)}^ {2} < \chi_ {(n - 1)}^ {2} (\frac {2}{2})(n - 1)) = 1 - \alpha$ ，得出 $\sigma^2$ 的 $1 - \alpha$ 可信区间为

$$
\left(\frac {(n - 1) s ^ {2}}{\chi_ {1} ^ {2} (n - 1)}, \quad \frac {(n - 1) s ^ {2}}{\chi_ {1} ^ {2} \left(1 - \frac {\alpha}{2}\right) (n - 1)}\right)
$$

例2 调查6例60岁老人的胆固醇指标，得s为0.667 mmol/L，$ \mathrm{s}^{2} = 0.4455 $。假定胆固醇指标服从正态分布 $ \mathrm{N}(\mu ,\sigma^{2}) $求 $\sigma^2$ 的 $ 95\% $可信区间。

因 $\mu$ 未知，从 $x'$ 表查得 $x_{29.5}^{*}=12.8, x_{29.5}^{*} = 0.831$，代入计算 $(n - 1)^{2} / x_{29.5}^{*} \approx 0.0178, (n - 1)^{2} / x_{205.5}^{*} \approx 2.6808$，所以 $\sigma^{2}$ 的 $95\%$ 可信区间为 $(0.124, 2.6808)$。

## 总体比例数估计

总体比例数估计 (estimation of population proportion) 是根据样本数据 (由定性变量组成) 估计出总体的比例数。这里的比例数可以是率，也可以是构成比，因此，也可称为总体率估计或总体构成比估计。

(1) 点估计：设从比例数（率或构成比）为P的总体中抽取大小为n的一个样本，观测到其中k个有某种特性，则得样本统计量 $\frac{\mathrm{k}}{\mathrm{n}}$ 。总体P用矩法估计和最大似然法估计都可获得 $\hat{P} = \frac{\mathrm{k}}{\mathrm{n}}$ 的估计公式。

(2) 区间估计，因为k服从二项分布，所以可根据二项分布表查出P的 $1 - \alpha$ 可信区间 $(\mathrm{P}_{1 - \frac{\alpha}{2}}, \mathrm{P}_{\frac{\alpha}{2}})$，实际中可直接查n,k对应的P的 $1 - \alpha$ 可信区间表(附录四表10)。例如，n=15,k=6，由附录四表10查得P的 $95\%$ 可信区间为 $16\% - 68\%$ 。当n可从表中查到，而K查不到时，可查1-P的可信区间，再用推算方法得到P的可信区间，如n=25,K=20，先查n=25,K=25-20=5对应的可信区间得 $7\% - 41\%$ ，然后用 $100\%$去减，得 $59\% - 93\%$ 即为所求P的 $95\%$ 可信区间。当n或n与K都不到时，可用邻近值近似的可信区间。当n值超过表中最大n值时，nP和n(1-P)又不小于5时，可通过正态近似，用

$$
\left(\hat {P} - Z _ {a} \sqrt {- \frac {\hat {P} (1 - \hat {P})}{n}}, \hat {P} + Z _ {a} \sqrt {\frac {\hat {P} (1 - \hat {P})}{n}}\right)
$$

计算P的 $1 - \alpha$ 可信区间。

(3) 两个总体率差的空间估计，假定从率为 $P_{1}, P_{2}$ 的两个总体中分别抽取大小为 $n_{1}, n_{2}$ 的一个样本，分别得样本率 $\hat{P}_1$ 与 $\hat{P}_2$ ，则当 $n_1$ 与 $n_2$ 足够大时， $1 - \alpha$ 可信区

间为：

$$
\left[ \left(\hat {P} _ {1} - \hat {P} _ {2}\right) - Z _ {a} s \hat {p} _ {1} - \hat {p} _ {2}, \left(\hat {P} _ {1} - \hat {P} _ {2}\right) + Z _ {a} s \hat {p} _ {1} - \hat {p} _ {2} \right]
$$

其中

$$
s _ {\hat {P} _ {1} - \hat {P} _ {2}} = \sqrt {\frac {\hat {P} _ {1} \left(1 - \hat {P} _ {1}\right)}{n _ {1}} + \frac {\hat {P} _ {2} \left(1 - \hat {P} _ {2}\right)}{n _ {2}}}
$$

例 调查83名原发性高血压儿童的 185名一级亲属183名高血压病史，并对80名血压正常儿童的184名一级亲属作同样调查，患病率分别为 $13.1\%$ 和 $2.7\%$ ，求差别 $10.4\%$ 的可信度。

此例中， $\hat{P}_1 = 13.1\%$ ， $\hat{P}_2 = 2.7\%$ ，差值 $= \mathrm{P}_{1} - \mathrm{P}_{2} - 10.4\%$ 。从式(3)，得

$$
s _ {\hat {p} _ {1}} \dot {s} _ {2} = \sqrt {\frac {0 . 1 3 1 \times 0 . 8 6 9}{1 8 3}} \times \frac {0 . 0 2 7 \times 0 . 9 7 3}{1 8 4} = 0. 0 2 7 7
$$

从式（2），得

$$
\begin{array}{l} \left(\mathrm {P} _ {1} - \mathrm {P} _ {2}\right) \text {的} 95 \% \text {可信限} = 0. 1 0 4 \pm 1. 9 6 \times 0. 0 2 7 7 \\ = 0. 0 5 0 - 0. 1 5 8 \\ \end{array}
$$

这一可信限不包括0值，表示高血压病有家庭聚集性，患高血压儿童的一级亲属比正常儿童的亲属患频率高出 $5\% -15.8\%$ 。

## 刀切法

刀切法(jackknife)是将样本含量陆续减少1个（或k个），组成一系列新样本，再从新样本得到参数估计量的统计方法。当参数的估计量有偏时，可用刀切法得到偏性较小或不偏统计量，称为刀切统计量。这统计量可用于作t检验，计算可信限等。其计算步骤如下：

(1) 设从某一种分布的总体抽出的一个样本为 $X_{1}, X_{2} \dots X_{n}$; $\hat{n}_{\mathrm{r}(X_1 \dots X_n)}$ 是总体的某一参数的有偏估计 $[\hat{\theta} = f(x)]$。

(2) 把样本的n个数据，分成j组，每组有k个个体数。则 $n = jk$ 。通常取 $k = 1, j = n$ ，这种分组尤其是n较小时常用。

(3) 每次剔除1个数据，作为新样本。这新样本有 $n - 1$ 个的个体数据，仍用原来的参数估计公式 $\hat{\theta} = f(x)$，得出 $\theta$ 的估计值 $\hat{\theta}$。共有n个新样本，得n个 $\theta$ 估计值，记 $\hat{\theta}_{1} =$ 为第i组估计值。

如果一次剔除含量为k的一组数据，则新样本的含量为n-k个数据。一共有j个新样本，用原估计公式，对每个新样本算出估计值。记剔除第i组后新样本估计值为$\hat{\theta}_{j-1, i0}^{1}$

(4) 计算虚拟值 $ \hat{\theta}_{1} $

$$
\begin{array}{l} \hat {\theta} _ {1} = \mathrm {n} \hat {\theta} _ {n} - (n - 1) \hat {\theta} _ {n - 1} ^ {2} \\ \hat {\theta} _ {1} = \mathrm {j} \hat {\theta} _ {n} - (\mathrm {j} - 1) \hat {\theta} _ {j - 1} ^ {2} \\ \end{array}
$$

前一式 $k = 1, n = j$ ，后一式 $k > 1, n = jk$ 。

(5) 计算虚拟值的平均：

$$
\begin{array}{l} J _ {\theta} = \frac {1}{n} \sum_ {i = 1} ^ {n} \hat {\theta} _ {i} \\ J _ {\theta} = \frac {1}{J} \sum_ {i = 1} ^ {J} \hat {\theta} _ {i} \\ \end{array}
$$

$J_{0}$ 称为 $\theta$ 的刀切统计量，其偏性比 $\hat{q}_{n}$ 小。其误差为：

$$
s _ {1 0} = \sqrt {\frac {\sum \left(\theta_ {1} - J _ {0}\right) ^ {2}}{n (n - 1)}}, \quad k = 1, \text {自 由 度} = n - 1
$$

$$
s _ {j 0} = \sqrt {\frac {\sum \left(\hat {\theta} _ {1} - J _ {0}\right) ^ {2}}{j (j - 1)}}, \quad k > 1, \text {自由度} = j - 1
$$

$\mathrm{J}_0 / \mathrm{S}_{30}$ 服从 $v = n - 1$ （当 $k = 1$）或 $j - 1$ （当 $k > 1$）的 $t$ 分布。

例 在一个人群中随机抽取250人 $(n = 250)$，检查后知HBsAg阳性者2人（阳性者 $X = 1$，阴性者 $X = 0$），$\sum X = 2$。现用$\hat{\theta} = \frac{1 + \sum X}{n + 2}$公式估计参数 $\theta$。如此估计公式得到估计量是有偏的，用刀切法校正其偏性。

(1) 按此公式计算出参数估计值 $\hat{\theta}_0$

$$
\hat {\theta} _ {0} = \frac {1 + \sum X}{n + 2} = \frac {1 + 2}{2 5 0 + 2} = 0. 0 1 1 9 0 5
$$

(2) 把样本分成250组，每组1人，即 $ k=1,j=n=250。 $

(3) 删除第i组，用留下的249人为一新样本。计算250个新样本的估计值 $ \theta_{-1} $ ，结果见附表。

表中， $\hat{\theta}_{n - 1}^{1}$ 的计算公式同 $\hat{\theta}_{n0}$

(4) 计算虚拟值 $\hat{\theta}_1, \hat{\theta}_2 = n\hat{\theta}_0 - (n - 1)\hat{\theta}_1$；如第一行， $i = 1$，

$\hat{\theta}_1 = 250 \times 0.011905 - 249 \times 0.007968 = 0.992218$。各组的虚拟值，列于表最后一列。

(5) 计算刀切统计量 $J_{0} = \frac{1}{n}\sum \hat{b}_{x}^{2}$

$$
J _ {p} = \frac {1}{2 5 0} (0. 9 9 2 2 1 8 \times 2 + 0. 0 0 0 2 0 2 \times 2 4 8) = 0. 0 0 8 1 3 8 1 _ {\circ}
$$

(6) 计算刀切统计量的误差：

$ \mathrm{s}_{1 0}^{2}=\frac{\sum \left( \hat{\theta}_{i}-J_{4} \right)^{2}}{n (n-1)}=\frac{\left[ (0. 9 9 2 2 1 8-0. 0 0 8 1 3 8)^{2} \times 2+\left( 0. 0 0 0 2 0 2-0. 0 0 8 1 3 8 \right)^{2} \times 2 4 8 \right]}{2 4 9 \times 2 5 0}$

$ = 0. 0 0 0 0 3 1 3 6 4 6$

$ \mathrm{S}_{1 9}=0. 0 0 5 6, $自由度 $ n-1=2 4 9。 $

<div align="center">

刀切法计算举例

</div>

<table><thead><tr><th>剔除i组</th><th>新样本人数</th><th>阳性数</th><th>$\hat{\theta}_{n-1}^{1}$</th><th>虚拟值 $\hat{\theta}_{1}$</th></tr></thead><tbody><tr><td>1</td><td>249</td><td>1</td><td>0.007 968</td><td>0.992 218</td></tr><tr><td>2</td><td>249</td><td>1</td><td>0.007 968</td><td>0.992 218</td></tr><tr><td>3</td><td>249</td><td>2</td><td>0.011 952</td><td>0.000 202</td></tr><tr><td>4</td><td>249</td><td>2</td><td>0.011 952</td><td>0.000 202</td></tr><tr><td>5</td><td>249</td><td>2</td><td>0.011 952</td><td>0.000 202</td></tr><tr><td>6</td><td>249</td><td>2</td><td>0.011 952</td><td>0.000 202</td></tr><tr><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr><tr><td>250</td><td>249</td><td>2</td><td>0.011 952</td><td>0.000 202</td></tr></tbody></table>

用刀切法得到的阳性率估计量为 $0.81\% \pm 0.56\%$ 。对原来估计方法计算出来估计值的偏性有所纠正。总体阳性率的 $95\%$ 可信限为 $0.81 \pm t_{0.05}(2) \times 0.56\%$ 。

## 直线回归

## 直线回归

对两种或两种以上变量之间的联系，用一方程式来表达，这一方程式称为回归方程式(regression equation)，其统计分析方法称为回归分析(regression analysis)。如观察到的两种变量的成对数值，点在直角坐标上时，这些点的趋向直线形状，则可认为两者有直线（或线性）回归（linear regression）联系。表达这一联系的方程，称为直线回归方程式，如式(1)。

$$
\mathrm {Y} = \alpha + \beta \mathrm {X}
$$

式(1)中，X、Y均为变量。式(1)反映了这两个变量间的联系。如X为年龄(岁)、Y为体重(千克)，在幼儿期年龄与体重的调查结果经回归分析得：

$$
Y = 9 + 2 X
$$

这一结果可用于从幼年年龄估计体重。X前的系数 $\beta$，称为回归系数， $\alpha$ 称为截矩。

回归分析应用于 $\textcircled{1}$分析X,Y两个变量之间，是否存在一个有变化而另一个也随之增减的（线性）关系。$\textcircled{2}$利用回归方程式，估计出与某X值相对应的Y值，或预作为预测，修匀直线手段。$\textcircled{3}$用于进一步分析，如用来分析不同情况下，XY之间线性关系有否不同，对不同身高的正常人的肺活量变化范围作出估计；对两组身高不均衡的人，肺活量作估计等，可分别参见“回归线的比较”、“两变量参照值”、“协方差分析”等条目。

## 直线回归的分析步骤：

(1) 收集成对的实际数据，确定其中一个为自变量X，另一个为应变量Y。将各对数据点在直角坐标纸上，得散点图，如呈直线趋势则计算出这两个变量的平均数X、$\bar{Y}$，离均差平方和及乘积之和一 $-\sum (X - \bar{X})^2$。

$\sum (\mathrm{Y} - \bar{\mathrm{Y}})^{2},\sum (\mathrm{X} - \bar{\mathrm{X}})(\mathrm{Y} - \bar{\mathrm{Y}})$ ，分别以 $l_{xx},l_{yy}$ 及 $l_{xy}$ 表示。

(2) 求出 $ \beta, \alpha $的估计值，以b与a表示：

$$
\mathrm {b} = \frac {\mathrm {l} _ {\mathrm {X Y}}}{\mathrm {l} _ {\mathrm {X X}}}
$$

$$
\mathrm {a} = \bar {\mathrm {Y}} - \mathrm {b} \bar {\mathrm {X}}
$$

(3) 假设检验：可作方差分析或t检验。方差分析见“线性回归的方差分析”条。检验样本b是否从 $\beta = 0$ 的总体中抽出，可将样本的b、剩余标准差及X的离均差平方和代入下式得t值，

$$
t = \frac {b - 0}{S _ {\mathrm {Y} \cdot \mathrm {X}} / \sqrt {I _ {\mathrm {X X}}}}
$$

式（4）中，剩余标准差 $ S_{Y - X} $按式（5）算出：

$$
\begin{array}{l} S _ {\mathrm {Y}, \mathrm {X}} = \sqrt {\left(\mathrm {l} _ {\mathrm {Y Y}} - \mathrm {b} \cdot \mathrm {l} _ {\mathrm {X Y}}\right) / (n - 2)} \\ = \sqrt {\frac {\sum \left(Y - \hat {Y}\right) ^ {2}}{n - 2}} \\ \end{array}
$$

式(5)中， $\hat{\mathrm{Y}}$ 为应变量的预测值。

如果检验结果，不接受 $\beta = 0$ 原假设，说明XY之间存在互变的联系，否则不说明两者之间有关系。

直线回归分析须假定数据符合下列条件：$\textcircled{1}$X、Y之间呈直线关系，或在X值的观察范围内呈直线关系。$\textcircled{2}$每个X值的应变量Y，必须是互相独立的随机变量，并服从正态分布。不同X的应变量Y的剩余平方和，假定是齐性的。$\textcircled{3}$样本变量必须来自一个总体，如果样本中变量一部分来自某一总体，另一部分来自另一体质，则X与Y之间的关系将受影响。$\textcircled{4}$X值的测定，必须精确，即X值的测量误差应该很小。

此外，还应注意：

(1) 作回归分析时，应确定哪一个为自变量X，哪一个为应变量Y。确定时要有一定的理由，如将出现在先的，或对另一个变量来说是一种因素的，作为自变量；出现晚的或受前一个影响的，作为应变量。

自变量与应变量之间的关系不一定是因果关系。一批数据作出X为自变量、Y为应变量的回归方程式后，不能用简单代数移项方法得到以X为应变量的回归方程式。

(2) 应变量Y必须是一个随机变量。自变量X可以是人为规定的变量，如在毒理学实验时，动物接受的毒物剂量是研究者规定的。自变量也可以是随机变量，如调查幼儿园儿童的血铅浓度和智商之间的关系，血铅浓度X与智商Y都是随机变量。

例 大白鼠用. 种代乳糖饲养，得进食量X和增加体重Y的观察结果如下. 试求从X估计Y的直线回归方程. 并对回归系数b作 $\beta = 0$ 的假设检验.

$$
1 0 \mathrm {只 大 白鼠 的 进食量 (g) 和 增重 (g)}
$$

进食量 (X) 639 679 690 720 780 787 820 820 867 934

增 重 (Y) 120 145 134 130 158 167 158 165 180 180

(1) 从表中数据可看出当进食量X上升时，体重的增重量也随之而增。作散点图也可看出X、Y之间显直线关系（图略，或参见“直

线相关”），

(2) 计算回归系数b、截距a，列出回归方程式，先从表中数据计算出X、Y的均数、离均差平方和及乘积和、得

$$
\bar {X} = 7 7 3. 6
$$

$$
Y = 1 5 4. 3
$$

$$
J _ {x x} = \sum (X - \bar {X}) ^ {2} = 7 5 9 0 6. 4
$$

$$
1 _ {Y Y} = \sum \left(Y - \bar {Y}\right) ^ {2} = 4 2 3 4. 1
$$

$$
l _ {x y} = \sum (X - \bar {X}) (Y - \bar {Y}) = 1 6 8 4 3. 2
$$

从式（2）、（3）得：

$$
\mathrm {b} = \frac {l _ {X Y}}{l _ {X X}} = \frac {1 6 8 4 3 . 2}{7 5 9 0 6 . 4} = 0. 2 2 1 9
$$

$$
a = \bar {Y} - b \bar {X} = 1 5 4. 3 - 0. 2 2 1 9 \times 7 7 3 6 = - 1 7. 3 5 8
$$

得回归方程式： $ Y=-1 7. 3 5 8+0. 2 2 1 9 \mathrm {X} $

(3) 作假设检验， $H_{0}$ ： $\beta -0$ ，根据式（4）、（5）作t检验从式（5：

$$
\begin{array}{l} S _ {1, v} = \sqrt {\left(v _ {1 , v} - b _ {1 x}\right) / (n - 2)} \\ = \sqrt {(4 2 3 4 . 1 - 0 . 2 2 1 9 \times 1 6 8 4 3 . 2) / (1 0 - 2)} \\ = 7. 8 7 8 7 \\ \end{array}
$$

从式（4）.

$$
\begin{array}{l} t = \frac {b}{S _ {v x}} / \sqrt {1 _ {x x}} \\ = \frac {0 . 2 2 1 9}{7 . 8 7 8 / 7 / \sqrt {7 5 9 0 6 . 4}} \\ = 7. 7 6 \\ \end{array}
$$

$$
自 亩 度 = 1 0 - 2 = 8
$$

(4) 查附录四表 15. $ t_{\mathrm{coa}} > 2.306 $ 当 $ t=7.76 $ 时，$ \mathrm{P} < 0.05 $ 拒绝 $\beta = 0 $ 的原假说，说明回归系数b有显著性。每进入1g代乳粉，大白鼠体重增重0.22g。

## 回归值

回归值(regression value, $\hat{\mathbf{Y}}$)是将X值代入回归方程式计算出来的数值。它不是一个实际观察的Y值。它与$\hat{\mathbf{Y}}$相类似，是一种统计量，描述当X固定时Y值的集中趋势。在实际应用时，它又常被称为预测值。

实际观察值 $Y$ 和它相应的回归值 $\hat{Y}$ 之差的平方和 $\sum (\mathrm{Y} - \hat{\mathrm{Y}})^2$，称为剩余平方和。它的自由度为 $(n - 2)$。利用剩余平方和及其自由度，可计算，表示变量 $Y$ 与回归线之间的离散程度的标准差，称为标准估计误差（standard error of estimation），以 $S_{Y - X}$ 表示，其计算公式为

$$
s _ {Y, X} = \sqrt {\frac {\sum \left(Y - \hat {Y}\right) ^ {2}}{n - 2}}
$$

也可用下式计算：

$$
s _ {Y \cdot X} = \sqrt {\frac {l _ {Y Y} - l _ {X Y} ^ {2}}{n - 2}} \overline {{l _ {X X}}}
$$

式中， $l_{YY} - \sum (Y - \bar{Y})^2, l_{XY} = \sum (Y - \bar{Y})(X - \bar{X}).$

$$
l _ {X X} = \sum \left(X - \bar {X}\right) ^ {2} 。
$$

从式(1)可看出，标准估计误差的形式与标准差相似，以Y来代替标准差中的Y。它近似地表示X值固定后，Y值的离散情况。

## 线性回归方差分析

线性回归方差分析（ANOVA of linear regression）是检验回归方差与剩余方差间差别是否具显著意义的一种方法。其结果可用以说明自变量X对应变量Y有无显著影响。检验的意义与总体回归系数 $\beta = 0$ 的假设检验（t检验）是一致的；两者的结果也相同。

线性回归方差分析中，将总的平方和 $\sum (\mathrm{Y} - \bar{\mathrm{Y}})^2$ 分解为回归平方和 $\sum (\hat{\mathrm{Y}} - \bar{\mathrm{Y}})^2$ 与剩余平方和（又称残差平方和） $\sum (\mathrm{Y} - \bar{\mathrm{Y}})^2$ 两个部分，并计算出各自的自由度、均方，最后求得F值。

一个变量 Y与平均数 $ \bar{\mathrm{Y}} $的离差，是 $ (\mathrm{Y}-\bar{\mathrm{Y}}) $和 $ (\bar{\mathrm{Y}}- $ $ \bar{\mathrm{Y}} $ )两部分相加而成，

$$
(\mathrm {Y} - \bar {\mathrm {Y}}) = (\hat {\mathrm {Y}} - \bar {\mathrm {Y}}) + (\mathrm {Y} - \hat {\mathrm {Y}})
$$

把式(1)平方后，对所有变量的相应项求和，又因 $\sum (\hat{Y} -\bar{Y})(Y - \hat{Y}) = 0$ ，得式(2)：

$$
\sum \left(Y - \bar {Y}\right) ^ {2} = \sum \left(\hat {Y} - \bar {Y}\right) ^ {2} + \sum \left(Y - \hat {Y}\right) ^ {2}
$$

上式中 $\sum (\mathrm{Y} - \bar{\mathrm{Y}})^2$ 为总平方和，它为回归平方和与剩余平方和的相加。 $\sum (\mathrm{Y} - \bar{\mathrm{Y}})^2$ 部分与X变化无关，$\sum (\bar{\mathrm{Y}} - \bar{\mathrm{Y}})^2$ 部分则与X有关，是X与Y存在回归关系造成的。

$\sum (\hat{Y} -\bar{Y})^{2}$ 为回归引起的方差，可用式(3)计算。因 $\hat{Y} -\bar{Y} = b(X - \bar{X})$ ，所以

$$
\begin{array}{l} \sum \left(\hat {Y} - \bar {Y}\right) ^ {2} = b ^ {2} \sum \left(X - \bar {X}\right) ^ {2} \\ = \frac {\left[ \sum \left(X - \bar {X}\right) \left(Y - \bar {Y}\right) \right] ^ {2}}{\sum \left(X - \bar {X}\right) ^ {2}}. \\ \end{array}
$$

自由度为1，回归平方和除以自由度，得回归的均方值以 MS（回归）表示。

剩余平方和 $\sum (\mathrm{Y} - \hat{\mathrm{Y}})^2$，可依据式(2)，将 $\sum (\mathrm{Y} - \hat{\mathrm{Y}})^2$减去 $\sum (\mathrm{Y} - \hat{\mathrm{Y}})^2$而得，其自由度为 $(n - 2)$。剩余部分的均方为 $\sum (\hat{\mathrm{Y}} - \hat{\mathrm{Y}})^2 / (n - 2)$。按下式计算F值：

F=MS（回归）/MS（剩余）

与 $F_{\alpha(1,n - 2)}$ 作比较，如F值 $>F_{\alpha(1,n - 2)}$，可认为X对Y有显著作用。

例 8个2岁男孩体重和X线胸片心脏投影面积的测值(X, Y)为：

$$
(Y - \bar {Y}) ^ {2} = 1 9 8. 8 2 0,
$$

$\sum (X - \bar{X})^2 = 29.469$ ，b=1.72，n=8。试进行方差分析。

根据上述数据作方差分析表。

上表中根据式(2)，剩余平方和为总平方和减去回归平方和而很。F值为回归均方与剩余均方之比。查 $ \mathrm{F}_{0.05,1,n-2}=5.99 $ ，无显著意义。

方差分析中所得数值，可用来作回归系数b的假设检验和决定系数。回归系数的假设检验：原假设 $ \mathrm{H}_{0} $，为 $\beta = 0$ 。

(1) 求出样本的回归系数b及其标准误差 $ S_{n1} $

<table><thead><tr><th rowspan="2">变量来源</th><th rowspan="2">平方和</th><th rowspan="2">自由度</th><th colspan="4">例子数据</th></tr><tr><th>平方和</th><th>自由度</th><th>均方</th><th>F</th></tr></thead><tbody><tr><td>回归</td><td>b²Σ(X-X)²</td><td>1</td><td>87.181</td><td>1</td><td>87.181</td><td>4.68</td></tr><tr><td>剩余</td><td>Σ(Y-Y)²</td><td>n-2</td><td>111.638</td><td>6</td><td>18.606</td><td></td></tr><tr><td>合计</td><td>Σ(Y-Y)²</td><td>n-1</td><td>198.820</td><td>7</td><td></td><td></td></tr></tbody></table>

$$
\begin{array}{l} s _ {\mathrm {b}} = \frac {S _ {\mathrm {Y} , \mathrm {X}}}{\sqrt {\sum (\mathrm {X} - \bar {X}) ^ {2}}} \\ = \sqrt {\frac {\sum (\mathrm {Y} - \bar {Y}) ^ {2}}{n - 2}} \cdot \sqrt {\frac {1}{\sum (\mathrm {X} - \bar {X}) ^ {2}}} \\ = \sqrt {\frac {\sum (\mathrm {Y} - \bar {Y}) ^ {2} - b ^ {2} \sum (\mathrm {X} - \bar {X}) ^ {2}}{n - 2}} \sqrt {\frac {1}{\sum (\mathrm {X} - \bar {X}) ^ {2}}} \\ \end{array}
$$

(2) 计算t值：

$ t=\frac{b}{s_{b}} $自由度=n-2

(3) 查t表，得出结论。

例如，上例中，b=1.72

$$
b ^ {2} \sum (X - \bar {X}) ^ {2} = 8 7. 1 8 1, \sum (Y - \bar {Y}) ^ {2} = 1 9 8. 8 2 0
$$

$$
\sum \left(X - \bar {X}\right) ^ {2} = 2 9. 4 6 9, n = 8
$$

代入式（4）

$$
s _ {b} = \sqrt {\frac {1 9 8 . 8 2}{8} - \frac {8 7 . 1 8 1}{2}} \sqrt {\cdot \frac {1}{2 9 . 4 6 9}} = 0. 7 9 4
$$

$$
t = \frac {1 . 7 2}{0 . 7 9 4} = 2. 1 6,
$$

查t表 $ t_{0.05,6}=2.477,P>0.05 $ ，无显著意义。

决定系数(determinate coefficient)为回归平方和与总平方和的比值。

决定系数 $R = \frac{\sum (\hat{Y} - \bar{Y})^2}{\sum (\hat{Y} - \bar{Y})^2}$

$= 1 - \frac{\mathrm{l}_{\mathrm{Y},\mathrm{X}}}{\mathrm{l}_{\mathrm{Y},\mathrm{Y}}} = 1 - \frac{\sum (\hat{Y} - \bar{Y})^2}{\sum (\hat{Y} - \bar{Y})^2}$

决定系数能说明Y的变异多少成份可由因素X来解释。例如，在七例中决定系数R为 $87.181\div 198.820 = 0.438$ 。

## 回归线的比较

回归线的比较(comparison of regression lines)是指有两个或两个以上样本的回归线时，比较它们所代表的各总体回归线是否有相同的斜率 $\beta_{0}$ 和相同的截距（即 $\alpha_{1} = \alpha_{2}$）。比较结果可得如下几个结论：$\textcircled{1}$两个或多个样本所代表的总体回归线可认为是重合的。$\textcircled{2}$互相比较的回归线虽不重合，但相互平行；$\textcircled{3}$互相作比较的回归线是相交的。

各直线回归线作比较时，它们的X、Y变量应该有相同的测量单位，适于用直线模型予以拟合。直线回归线的比较这一统计方法，在医学中已有应用的实例，例如，分析两种药物或毒物混合使用时有无协同或拮抗作用等。

两个回归线比较 首先比较它们的回归系数有否区别。检验假设为 $\mathrm{H}_0: \beta_1 = \beta_2$。

(1) 如果剩余方差是相同的，用下式进行t检验。

$$
t = \frac {b _ {1} - b _ {2}}{\sqrt {\frac {s ^ {2} Y _ {1} x _ {1} \left(n _ {1} - 2\right) + s ^ {2} Y _ {2} x _ {2} \left(n _ {2} - 2\right)}{n _ {1} + n _ {2} - 4}} \left(\frac {1}{i _ {x 1 x 1}} + \frac {1}{i _ {x 2 x 2}}\right)}
$$

自由度为 $n_1 + n_2 - 4$ 。上式中， $s_{\mathrm{Y}_1, \mathrm{x}_1}, s_{\mathrm{Y}_2, \mathrm{x}_2}$ 分别为二回归线标准估计误差， $l_{\mathrm{Y}_1, \mathrm{x}_1}, l_{\mathrm{X}_2, \mathrm{x}_2}$ 分别为二回归线的剩余平方和。

(2) 如果剩余方差有显著差别（检验方差齐性的F检验认为方差不齐时），而样本含量较少，可用t分布近似方法，

$$
t ^ {\prime} = \frac {b _ {1} - b _ {2}}{\sqrt {\frac {S _ {k _ {1} , x _ {1}} ^ {2} - l _ {x _ {1} , x _ {1}}}{l _ {x _ {1} , x _ {1}}} + \frac {S _ {k _ {2} , x _ {2}} ^ {2} - l _ {x _ {2} , x _ {2}}}{l _ {x _ {2} , x _ {2}}}}}
$$

其自由度的计算方法为：

$$
\begin{array}{l} \nu^ {\prime} = \frac {1}{\frac {c ^ {2}}{n _ {1} - 2} + \frac {(1 - c) ^ {2}}{n _ {2} - 2}} \\ c = \frac {s _ {Y _ {1} - X _ {1}} ^ {2} / l _ {X _ {1} - X _ {1}}}{s _ {Y _ {1} - X _ {1}} ^ {2} / l _ {X _ {1} - X _ {1}} + s _ {Y _ {2} - X _ {2}} ^ {2} / l _ {X _ {2} - X _ {2}}} \dots \\ n _ {1} \leqslant n _ {2}. \\ \end{array}
$$

如果结果为拒绝 $\beta_{1} = \beta_{2}$ ，说明两条回归线的 $\beta$ 值不同。

(3) 如果两个回归线的回归系数相同（接受 $\beta_{1} = \beta_{2}$ 的假设），它们的截距(a)仍有可能不同，须进一步作截距a的比较。

$\mathrm{H}_{0}$ 为 $\alpha_{1} = \alpha_{2}$ 计算二条回归线的合并回归系数 $b_{c}$ 和合并剩余均方：

$$
b _ {c} = \frac {l _ {X _ {1} \cdot Y _ {2}} + l _ {X _ {2} \cdot Y _ {2}}}{l _ {X _ {1} \cdot X _ {1}} + l _ {X _ {2} \cdot X _ {2}}}
$$

$$
s _ {(V, x) C} ^ {2} = \left[ l _ {V _ {1} \cdot Y _ {1}} + l _ {V _ {2} \cdot Y _ {2}} - \frac {\left(l _ {X _ {1} \cdot Y _ {1}} + l _ {X _ {2} \cdot Y _ {2}}\right) ^ {2}}{l _ {X _ {1} \cdot X _ {1}} + l _ {X _ {2} \cdot X _ {2}}} \right] / \left(n _ {1} + n _ {2} - 3\right)
$$

$$
t = \frac {\bar {Y} _ {1} - \bar {Y} _ {2} - b _ {\mathrm {C}} \left(\bar {X} _ {1} - \bar {X} _ {2}\right)}{\sqrt {S _ {\mathrm {v} - \mathrm {v} - \mathrm {x}} \left[ \frac {1}{n _ {1}} + \frac {1}{n _ {2}} + \frac {\left(\bar {X} _ {1} - \bar {X} _ {2}\right) ^ {2}}{\mathrm {x} _ {1} \mathrm {x} _ {2} + \mathrm {x} _ {1} \mathrm {x} _ {2}} \right]}}
$$

自由度 $= \mathrm{n}_{1} + \mathrm{n}_{2} - 3$

多个回归线比较整个检验分四个部分：$\textcircled{1}$原假设 $\mathrm{H}_{0}$ 为各回归线是重合的（即各条线来自回归系数、截距相同的总体），如接受 $\mathrm{H}_{0}$，则继续第2部分。$\textcircled{2}$检验各线中的 $\beta$ 是否是相同的。如得出各线来自 $\beta$ 相同的总结，则继续第3部分。$\textcircled{3}$检验各线中的 $\alpha$ 是否是相同的。$\textcircled{4}$作多重比较。这一部分是在第2、3部分有显著意义结论时再进行。

多个直线的重合性检验 设 $H_{0}$ 为各线重合，即各样本所来自的总体有相等的回归系数和截距。设有k条回归线，作如下计算：

(1) 把全部数据合起来，计算出一条总的回归线 $\hat{\mathrm{Y}}_{\mathrm{T}} = \mathrm{a} + \mathrm{bx}$，及其剩余平方和：

$$
\mathrm {l} _ {(\mathrm {Y} - \mathrm {X}) \mathrm {T}} = \sum_ {(\mathrm {Y} - \hat {\mathrm {V}} _ {\mathrm {T}})} ^ {2} = \mathrm {l} _ {(\mathrm {Y Y}) \mathrm {T}} - \frac {\mathrm {l} _ {(\mathrm {X Y})} ^ {2} \mathrm {T}}{\mathrm {l} _ {(\mathrm {X X}) \mathrm {T}}}
$$

(2) 分别计算出各条回归线方程式 $\bar{\mathrm{Y}}_1 = \mathrm{a}_1 + \mathrm{b}_1\mathrm{x}_{11}$ 及各线的剩余平方和：

$$
\mathrm {l} _ {(\mathrm {V} \cdot \mathrm {X}) 1} = \sum \left(\mathrm {Y} _ {1} - \hat {\mathrm {Y}} _ {1}\right) ^ {2} = \mathrm {l} _ {(\mathrm {Y Y}) 1} - \frac {\mathrm {l} _ {(\mathrm {X Y}) 1} ^ {2}}{\mathrm {l} _ {(\mathrm {X X}) 1}}
$$

(3) 计算F值：

$$
F = - \frac {\left[ l _ {(\mathrm {Y} - \mathrm {T})} - \sum_ {i = 1} ^ {k} l _ {(\mathrm {Y} - \mathrm {i})} \right] / (2 k - 2)}{\sum_ {i = 1} ^ {k} l _ {(\mathrm {Y} - \mathrm {i})} / (\mathrm {N} - 2 k)}
$$

式中 $1_{(YY)T} = \sum_{i=1}^{k} 1_{Y_i-Y_i} 1_{(XX)_T} = \sum_{i=1}^{k} 1_{X_i-X_i} 1_{(YY)_T} = \sum_{i=1}^{k} 1_{X_i-Y_i}$ $1_{(Y-X)} = 1_{X_i-Y_i} 1_{(XX)_T} = 1_{X_i-X_i} 1_{(YY)_T}$ N为所有成对的(X, Y)数,k为回归线数。如 $F > F_{0.05(2k-2)(N-2k)}$，则表示差别有显著意义，说明各回归线不是重合的。

各回归系数间的检验 设有k个样本，分别有k个回归系数。 $H_{i};\beta = \beta_{i} = 1 - i - k)$ $\beta_{i}$为各样本的总体回归系数，$\beta$为其倍值。分别按下式计算A和B值，再作F检验。

$$
A = \sum_ {i = 1} ^ {k} I _ {(Y Y) i} - \frac {\sum_ {i = 1} ^ {k} I _ {(X Y) i}}{\sum_ {i = 1} ^ {k} I _ {(X X) i}}
$$

$$
B = \sum_ {i = 1} ^ {k} \left[ l _ {(Y Y) i} - \frac {l _ {(X Y) i} ^ {2}}{l _ {(X X) i}} \right]
$$

计算F值：

$$
F = \frac {[ A - B ] / (k - 1)}{B / (N - 2 k)}
$$

如 $ \mathrm{F}\geqslant \mathrm{F}_{0.05\mathrm{ak}}11(\mathrm{N}-2\mathrm{k}) $ ，表示各回归系数不全相等。

截距差则检验。如果 $B = B$，须进一步作各截距差别的检验。 $H_{\mathrm{a}}: \alpha_{1} = \alpha_{2} (i = 1\dots k)$，用前而的计算结果，按下式计算F值，并作F检验。

$$
F = \frac {\left[ I _ {(Y , X) T} ^ {- A} \right] / (k - 1)}{A / (N - k - 1)}
$$

如 $ \mathrm{F}\geqslant \mathrm{F}_{0.05(\mathrm{k}-1)(\mathrm{N}-2\mathrm{k})} $表示各回归线的截距不全相等。

多重比较（或两两比较）当上两步即第2,3部分中F检验有显著意义时，需进一步分析哪两个之间有显著差别。此时，可用Newman-Kuels的q检验来完成。先将回归系数按数值大小颠序排列，计算出s<sub>n</sub>，再计算出q值。

$$
s _ {\mathrm {b}} = \sqrt {\frac {\mathrm {B}}{\mathrm {N} - 2}} \frac {\mathrm {k}}{\mathrm {k}} \times \frac {1}{2} \left(\frac {1}{\left(\mathrm {l} _ {\mathrm {x x}}\right) _ {\mathrm {t}}} + \frac {1}{\left(\mathrm {l} _ {\mathrm {x x}}\right) _ {\mathrm {n}}}\right)
$$

$$
q = \frac {b _ {1} - b _ {1 1}}{s _ {b}}
$$

根据自由度（N-2k）及I、II相隔（包括I、II本

身)组数，查q临界值表，作出结论。

用类似步骤作截距的两两比较。用下式计算 $ \mathrm{s_a} $及q值；

$$
s _ {n} = \sqrt {\frac {A}{(N - k - 1)}} \times \frac {1}{2} \left[ \frac {1}{n _ {1}} + \frac {1}{n _ {1}} - \frac {\left(\bar {X} _ {1} - \bar {X} _ {N}\right) ^ {2}}{\left(l _ {X X}\right) _ {1} + \left(l _ {X X}\right) _ {N}} \right]
$$

$$
q = \frac {a _ {\mathrm {I}} - a _ {\mathrm {H}}}{s _ {\mathrm {a}}}
$$

根据自由度 $(N - k - 1)$ 及I、II两线a值相隔组数（包括I、II本身），查q临界值表，作出结论。

例 在三个托儿所，测定2岁男孩的体重（X）与心形面积

（Y），得数据如表1，试作回归分析。

<div align="center">

表1 三个托儿所2岁男孩的体重（X）与心形面积（Y）

</div>

<table><thead><tr><th>组别</th><th>人数</th><th>(X, Y)</th></tr></thead><tbody><tr><td>1</td><td>8</td><td>(9, 29.2), (12, 35.4), (10, 33.5), (12, 39.4), (12, 37.7), (10, 40.4), (15.5, 41.3) (13, 46.7)</td></tr><tr><td>2</td><td>4</td><td>(11, 40.5), (14, 46.8), (12, 43.0), (11.5, 35.8)</td></tr><tr><td>3</td><td>4</td><td>(11, 36.0), (11.5, 44.4), (10.5, 41.2), (13, 34.8)</td></tr></tbody></table>

1. 分别作回归分析，得各数值如表 $2_{n}$

<div align="center">

表2 三个托儿所2岁男孩体重与心形酉积回归系数等数值

</div>

<table border="1"><tr><td>组别(i)</td><td>n</td><td>X</td><td>Y</td><td>lxx</td><td>lyy</td><td>lxy</td><td>b</td><td>a</td><td>lxx=Σ(Y-Y)2</td><td>自由度</td></tr><tr><td>1</td><td>8</td><td>11.96</td><td>37.95</td><td>29.469</td><td>199.82</td><td>50.725</td><td>1.7</td><td>17.83</td><td>111.50</td><td>6</td></tr><tr><td>2</td><td>4</td><td>12.125</td><td>41.525</td><td>5.188</td><td>63.83</td><td>14.438</td><td>2.78</td><td>7.78</td><td>23.65</td><td>2</td></tr><tr><td>3</td><td>4</td><td>11.5</td><td>39.100</td><td>3.500</td><td>60.60</td><td>-7</td><td>-2</td><td>62.1</td><td>46.60</td><td>2</td></tr><tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td>181.75(B)</td><td>10</td></tr><tr><td></td><td></td><td></td><td></td><td>38.157</td><td>324.25</td><td>58.163</td><td></td><td></td><td>235.59(A)</td><td>16-3-1-12</td></tr><tr><td></td><td>16</td><td>11.75</td><td>39.11</td><td>37</td><td>359.42</td><td>62.45</td><td>1.6</td><td>20.29</td><td>254.01(T)</td><td>14</td></tr></table>

2. 计算剩余平方和：

$$
\mathrm {l} _ {\mathrm {(y . x) T}} = \mathrm {l} _ {\mathrm {(y y) T}} - \mathrm {l} _ {\mathrm {(x y) T}} / \mathrm {l} _ {\mathrm {(x x) T}}
$$

$$
= 3 5 9. 4 2 - 6 2. 4 5 ^ {2} / 3 7 = 2 5 4. 0 1
$$

自由度 $ = \sum \tilde{\mathrm{n}}_{1}-2=N-2=14 $

$$
\mathrm {B} = \sum_ {i = 1} ^ {b} \left[ \mathrm {l} _ {\left(\mathrm {Y Y}\right)} - \mathrm {l} _ {\left(\mathrm {X Y}\right)} / \mathrm {l} _ {\left(\mathrm {X X}\right)} \right] = 1 8 1. 7 5
$$

自由度 $ = \sum \left(n_{1}-2\right)=N-2 k=10 $

$$
\begin{array}{l} A = \sum_ {i = 1} ^ {n} l _ {i x y z} ^ {1} + \sum_ {i = 1} ^ {n} l _ {i x y z} ^ {2} / \sum_ {i = 1} ^ {n} l _ {i x y z} ^ {3} \\ = 3 2 4. 2 5 - 5 8. 1 6 3 ^ {2} / 3 8. 1 5 7 = 2 3 5. 5 9 \\ \end{array}
$$

自由度 $ = \sum n_{i} - k - 1 = N - k - 1 = 1 2 $

(1) $ \mathrm{H}_{0} $：各回归线重合，

3. 计算F值：

$$
\mathrm {F} = \frac {\left(\mathrm {l} _ {\mathrm {a} , \mathrm {x} , \mathrm {r} - \mathrm {B}}\right) / (2 \mathrm {k} - 2)}{\mathrm {B} / (\mathrm {N} - 2 \mathrm {k})} = \frac {(2 5 4 . 0 1 - 1 8 1 . 7 5) / 4}{1 8 1 . 7 5 / 1 0} = 0. 9 9
$$

(2) $ \mathrm{H}_{0:} $ $ \beta_{1}=\beta_{2}=\cdots=\beta_{k} $

$$
\begin{array}{l} F = \frac {(A - B) / (k - 1)}{B / (N - 2 k)} = \frac {(2 3 5 . 5 9 - 1 8 1 . 7 5) / 2}{1 8 1 . 7 5 / 1 0} \\ = 1. 4 8 \\ \end{array}
$$

$$
\mathrm {H} _ {0 1} \alpha_ {1} = \alpha_ {2} \dots = \alpha_ {1 2},
$$

$$
\begin{array}{l} F = \frac {\left(\mathrm {I} _ {\mathrm {w} \mathrm {n} \mathrm {s} \mathrm {t}} - A\right) / (\mathrm {k} - 1)}{\mathrm {A} / (\mathrm {n} - \mathrm {k} - 1)} = \frac {(2 5 4 . 0 1 2 3 5 . 0 1) / 2}{2 3 5 . 5 9 / 1 0} \\ = 0. 4 0 \\ \end{array}
$$

3个F值，分别查 $ \mathrm{F}_{0.05,1.01} \mathrm{F}_{0.05,2.01} \mathrm{F}_{0.05,3.10} $相比，均无显著性。

说明这三条回归线条不拒绝相等性假设，各直线的回归系数、截距可以是相等的。

4. 此例回归系数和截距不必进行两两比较。现仅为说明运算方法，以回归系数为例，作下列检验。

各组按回归系数大小排列次序，算出各个两组比较时，b的标准误s，查出 $ q_{o} $ (p,n)值。

<div align="center">

表3 三个托儿所2岁儿童的体重、心形面积回归系数的多重比较

</div>

<table border="1"><tr><td>原组别</td><td>组别</td><td>b</td><td>比较</td><td>差别</td><td>Sb</td><td>q0.05(2.10)</td><td>Sbq0.05(2.10)</td></tr><tr><td>3</td><td>Ⅰ</td><td>-2</td><td>b1-bH</td><td>|3.72|</td><td>1.70</td><td>3.15</td><td>5.36</td></tr><tr><td>1</td><td>Ⅱ</td><td>1.72</td><td>b2-bH</td><td>|1.06|</td><td>1.43</td><td>3.15</td><td>4.52</td></tr><tr><td>2</td><td>Ⅲ</td><td>2.78</td><td>bH-bi</td><td>|4.78|</td><td>2.20</td><td>3.88</td><td>8.54</td></tr></table>

b与b比较中，

$$
\begin{array}{l} s _ {0} = \sqrt {\frac {B}{(N - 2 k)} \times \frac {1}{2} \left(\frac {1}{1 _ {(k + 1)}} + \frac {1}{1 _ {(k + 1)}}\right)} \\ = \sqrt {\frac {1 8 1 . 7 5}{(1 6 - 6)} \times \frac {1}{2} \left[ \frac {1}{3 . 5} + \frac {1}{2 9 . 4 69} \right]} = 1. 7 0 \\ \varphi_ {0 0 5 (2)} = 3. 1 5 \\ \end{array}
$$

余按此类推。各组比较均无显著差别。表明各条回归线可以相互合并，无必要作单独处理。

## 列联表趋势检验

列联表趋势检验(test for trend of contingency)是一种检验两个有序分类变量是否存在线性回归关系的 $\chi^2$ 检验法。

这一方法广泛应用于流行病学研究中阐明剂量与反应关系的研究。作为因素的变量，常分成k个（k $\geqslant$ 3）等

级，作为反应的变量是“发病与不发病”、“死亡与存活”等二项分类变量。此时因素与反应构成一个 $k \times 2$ 列联表，相应的趋势检验也称为 $k \times 2$ 列联表趋势检验。如果作为反应的变量可分为r级，则因素与反应构成一个 $k \times r$ 列联表，相应的趋势检验是 $k \times r$ 列联表趋势检验。

k×2列联表趋势检验 进行这一检验时，将因素变量的不同水平用“记分”（score)定量化，把0分放在中间水平，比它小用的-1、-2等记分，比它大的水平用1、2等记分，把 $z_{i}$ 作为因素变量的各水平记分，反应变量分两个水平，以 $X_{i}$ 代表i水平的发病数（或死亡数等）， $n_{i}-X_{i}$

代表不发病数（或生存数等）。 $X$ 为 $\sum X_{1}, n$ 为 $n_{1c}$

是否存在随 $z$ 水平的变化，发病率（或死亡率）等也随之而变化的现象，只须作以下 $x^{2}$ 检验。检验假设为发病率的变化与 $z$ 水平的变化无关，即 $\mathrm{H}_{\mathrm{a}}:\beta = 0.$ $x^{2}$ 计算公式为：

$$
\chi^ {2} = \mathrm {b} ^ {2} / \mathrm {s} ^ {2}, \quad \mathrm {自 由 度} = 1
$$

其中

$$
b = \frac {n \sum X _ {i} z _ {i}}{n \sum n _ {i} z _ {i} ^ {2}} - \frac {X \sum n _ {i} z _ {i}}{(\sum n _ {i} z _ {i}) ^ {2}}
$$

$$
s _ {t} = \sqrt {P (1 - \hat {P}) \left[ \sum n _ {i} z _ {i} ^ {2} - \left(\sum n _ {i} z _ {i}\right) ^ {2} / n \right]}
$$

例1 31例胃癌病理检查的癌组织侵犯胃壁的深度与五年生存率见表1，试作趋势检验。

<div align="center">

表1 31例胃癌的病变深度与生存率的线性关系

</div>

<table><thead><tr><th>侵犯胃壁深度</th><th>记分 z<sub>i</sub></th><th>五年有活数 X<sub>i</sub></th><th>死亡数 n<sub>i</sub> - X<sub>i</sub></th><th>n<sub>i</sub></th><th>P<sub>i</sub></th><th>(1 - P<sub>i</sub>)</th><th>X<sub>i</sub>z<sub>i</sub></th><th>X<sub>i</sub>z<sub>i</sub>²</th><th>n<sub>i</sub>z<sub>i</sub></th><th>n<sub>i</sub>z<sub>i</sub>²</th></tr></thead><tbody><tr><td>粘膜及其下层</td><td>-1</td><td>3</td><td>0</td><td>3</td><td>1.00</td><td>0</td><td>-3</td><td>3</td><td>3</td><td>3</td></tr><tr><td>肌层</td><td>0</td><td>5</td><td>6</td><td>11</td><td>0.455</td><td>0.545</td><td>0</td><td>0</td><td>0</td><td>0</td></tr><tr><td>浆膜及网膜</td><td>1</td><td>3</td><td>13</td><td>16</td><td>0.188</td><td>0.812</td><td>3</td><td>3</td><td>16</td><td>16</td></tr><tr><td></td><td></td><td>X = 11</td><td></td><td>n - 30</td><td>0.354 8</td><td>0.645 2</td><td>0</td><td>6</td><td>13</td><td>19</td></tr></tbody></table>

设生存率的大小与侵犯胃壁的深度无关，即 $H_0: \beta = 0$ 。应用上述公式，分别计算b、 $s_{0s}$ 和 $X^2$ 值：

$$
\begin{array}{l} b = \frac {3 0 \times 0 - 1 1 \times 1 3}{3 0 \times 1 9 - 1 3 ^ {2}} = - 0. 3 5 6 6 \\ s _ {0} = \sqrt {0. 3 5 6 6 ^ {2} \times 0. 6 4 3 4 [ 1 9 - 1 3 ^ {2} / 3 0 ]} = 1. 7 5 1 \\ \end{array}
$$

$$
X ^ {2} = \frac {b ^ {2}}{s _ {0} ^ {2}} = \frac {0 . 3 5 7 ^ {2}}{1 . 7 5 1 ^ {2}} = 0. 0 4
$$

不拒绝 $\Pi_{n};\beta = 0$ 的假设。说明生存率大小与侵犯胃壁深度无关。

$k \times r$列联表趋势检验与 $k \times 2$ 相仿，处理时先将因素与反应两个变量不同水平用记分定量化。然后用下列公式进行计算：

$$
b _ {y - x} = \frac {l _ {x y}}{l _ {x x}} = \frac {\left[ \sum \left(x - \bar {x}\right) ^ {2} + \sum \left(y - \bar {y}\right) ^ {2} - \sum \left(d - \bar {d}\right) \right] / 2}{\sum \left(x - \bar {x}\right) ^ {2}}
$$

$$
V _ {b} = \frac {\mathrm {l} _ {Y Y}}{\mathrm {n l} _ {X X}} = \frac {\sum \left(y - \bar {y}\right) ^ {2}}{b \sum \left(X - \bar {X}\right) ^ {2}}
$$

$$
\chi^ {2} = \frac {\mathrm {b} ^ {2}}{\mathrm {V} _ {\mathrm {b}}}
$$

其中d为（x-y）（见表3）。

例2 有541例结核性脑膜炎病例按治疗时病情早晚程度分早、中、晚三期，有篷症、有后遗症、死亡二种不问程度的结果，数据列于表2，试作检验。

(1) 计算 $\sum (\mathrm{Xn}_i)_i, \sum (\mathrm{X}^2 \mathrm{n}_i)_i, \sum (\mathrm{Yn}_i)_i, \sum (\mathrm{Y}^2 \mathrm{n}_i)$。本例 $\sum (\mathrm{Xn}_i) = -13, \sum (\mathrm{X}^2 \mathrm{n}_i) = 275, \sum (\mathrm{Yn}_i) = -155, \sum (\mathrm{Y}^2 \mathrm{n}_i) = 439$ (表2)。

(2) 计算

$$
\begin{array}{l} \mathrm {l} _ {\mathrm {X X}} = \sum \left(X - \bar {X}\right) ^ {2} = \sum \left(X ^ {2} n _ {\mathrm {u}}\right) - \left[ \sum \left(X n _ {\mathrm {u}}\right) \right] ^ {2} / \sum n _ {\mathrm {u}} \\ 2 7 5 - (- 1 3) ^ {2} / 5 4 1 = 2 7 4. 6 8 8 \\ \mathrm {l} _ {\mathrm {Y Y}} = \sum \left(Y - Y ^ {\prime}\right) ^ {2} = \sum n _ {\mathrm {u}} Y ^ {2} / \sum n _ {\mathrm {u}} \\ = 4 3 9 - (- 1 5 5) ^ {2} 5 4 1 = 3 9 4. 3 9 1 \\ \end{array}
$$

(3) 计算 $ \mathrm{l}_{xy} $ ，领先计算出表3各数据。

<div align="center">

表2 511例结核性脑膜炎病清严重度与后果的列联表

</div>

<table border="1"><tr><td rowspan="2">病情(X)</td><td rowspan="2">记分</td><td colspan="3">治疗效果(Y)</td><td rowspan="2">nk</td><td rowspan="2">Xnk</td><td rowspan="2">X2nk</td></tr><tr><td>痊愈-1</td><td>有后遗症0</td><td>死亡1</td></tr><tr><td>早期</td><td>-1</td><td>113</td><td>13</td><td>18</td><td>144</td><td>-144</td><td>144</td></tr><tr><td>中期</td><td>0</td><td>142</td><td>59</td><td>65</td><td>266</td><td>0</td><td>0</td></tr><tr><td>晚期</td><td>1</td><td>42</td><td>30</td><td>59</td><td>131</td><td>131</td><td>131</td></tr><tr><td>n1</td><td></td><td>297</td><td>102</td><td>142</td><td>541</td><td>-13</td><td>275</td></tr><tr><td>yn1</td><td></td><td>-297</td><td>0</td><td>142</td><td>-155</td><td></td><td></td></tr><tr><td>y2n1</td><td></td><td>297</td><td>0</td><td>142</td><td>439</td><td></td><td></td></tr></table>

<div align="center">

表3 k×r列联表的趋势检验步骤举例

</div>

<table border="1"><tr><td>X-Y</td><td>d</td><td>f</td><td>df</td><td>d2f</td></tr><tr><td>(-1)-(+1)</td><td>-2</td><td>18</td><td>-36</td><td>72</td></tr><tr><td>0-(+1)(-1)0</td><td>-1</td><td>6513}78</td><td>-78</td><td>78</td></tr><tr><td>(+1)+(+1)0-0(-1)-(-1)</td><td>0</td><td>5959133}231</td><td>0</td><td>0</td></tr><tr><td>(+1)-00-(-1)</td><td>+1</td><td>30142}172</td><td>172</td><td>172</td></tr><tr><td>(+1)-(-1)</td><td>+2</td><td>42</td><td>84</td><td>168</td></tr><tr><td>合计</td><td></td><td>541</td><td>142</td><td>490</td></tr></table>

$$
l _ {a a} = \sum (d - d) ^ {2} = \sum d ^ {2} f - \frac {\left(\sum d f\right) ^ {2}}{n} = 4 9 0 - \frac {1 4 2 ^ {2}}{5 4 1} = 4 5 2. 7 2 8
$$

$$
\begin{array}{l} I _ {x v} = \left[ I _ {x x} + I _ {y y} - I _ {a d} \right] / 2 = (2 7 4. 6 8 8 + 3 9 4. 5 9 1 - 4 5 2. 7 2 8) / 2 \\ = 1 0 8. 2 7 6 4 \\ \end{array}
$$

(4) 计算 $ \mathbf{b}_{1}\mathbf{V}_{b} $和 $ \mathbf{x}^{2}_{1} $

$$
b = \frac {l _ {x y}}{l _ {x x}} = \frac {1 0 8 . 2 7 6}{2 7 4 . 6 8 8} = 0. 3 9 4
$$

$$
V _ {b} = \frac {\mathrm {l} _ {Y Y}}{\mathrm {n} l _ {x x}} = \frac {3 9 4 . 5 9 1}{5 4 1 \times 2 7 4 . 6 8 8} = 0. 0 0 3
$$

$$
\chi^ {2} = \frac {\mathrm {b} ^ {2}}{\mathrm {V} _ {\mathrm {b}}} = \frac {0 . 3 9 4 ^ {2}}{0 . 0 0 3} = 5 1. 7 4 5, \text {自 由 度} = 1
$$

此 $x^{*}$ 值大于 $x^{*}_{0011}, P < 0.05$。有显著意义，说明结核性脑膜炎病情的严重度与治疗结果有线性回归关系，病情越严重，治疗结果越差。

## 直线相关

## 直线相关

直线相关(linear correlation)是研究两种随机变量之间的关系的统计方法，用来阐明两者之间关系的性质和程度。

两种变量之间的关系主要是通过相关系数来描述的，用符号r表示。相关系数又称为积矩相关系数，只用于两者呈直线（或线性）关系，即一个变量数值上升时，另一个出现上升或下降的趋势是呈直线形状的。

相关系数的计算公式为：

$$
r = \frac {\sum (X - \bar {X}) (Y - \bar {Y})}{\sqrt {\sum (X - \bar {X}) ^ {2} \cdot \sum (Y - \bar {Y}) ^ {2}}} = \frac {l _ {x y}}{\sqrt {l _ {x x} \cdot l _ {y y}}}
$$

r值在-1与1之间，设有单位。当r为负值时称为负相关。r为正值时称为正相关。r绝对值越接近1，相关程度越高，等于1时，称为完全相关。r值越接近0时，相关程度越低，等于0时，称为无相关。但在下结论之前应作相关系数假设检验。

两种变量之间关系，也可用散点图表示。横轴为变量X尺度，纵轴为变量Y尺度，每一对(X,Y)数值，作为坐标为(X,Y)的一个点，n对数据成为图上的n个点，从点的分布情况，可看出X与Y相关是正的(X值大时，Y值也较大)还是负的(X值大时，Y值趋向较小)；也可约略看出相关程度。

分析直线相关的条件是：$\textcircled{1}$X、Y两个变量之间星线性关系。$\textcircled{2}$X、Y两个变量均为随机变量。$\textcircled{3}$X、Y两个变量双变量正态分布。

成对的双变量数据，同时作相关分析、回归分析时，存在如下的关系：

(1) 在回归分析中，从X推算Y的回归系数 $b_{X-Y}$，与从Y推算X的回归系数 $b_{X-Y}$，是不同的数值，r是它们的几何平均值。

$$
r = \sqrt {b _ {Y - X} \cdot b _ {X - Y}}
$$

r的符号，取回归系数的符号。byx为正值时，r也为正值；为负值时，r也为负值；同一数据的b与r的正负符号相同。

(2) 如果变量X、Y通过 $X^{\prime} = \frac{X - \bar{X}}{Sx}, Y^{\prime} = \frac{Y - \bar{Y}}{Sy}$ 两式变换成正态变量X'、Y'。用正态变量计算而得回归方程式，称为标准化回归方程式。当自变量X只有一种时，其回归系数即为r值。

$$
Y ^ {\prime} = b ^ {\prime} X ^ {\prime}, \frac {Y - \bar {Y}}{S _ {Y}} = r \frac {X - \bar {X}}{S _ {X}}
$$

上式与 $Y - \bar{Y} = b_{r \cdot x}(X - \bar{X})$ 相比，可得

$$
r = b _ {Y} \cdot x \frac {S _ {Y}}{S _ {X}}
$$

同理， $\hat{X}^{\prime} = \mathrm{rY}^{\prime},\mathrm{r} = \mathrm{b}_{x - y}\frac{\mathrm{S}x}{\mathrm{S}y}$

(3) 决定系数是相关系数的平方值。

$$
\text {决 定 系 数} = \frac {l ^ {2} x y / l _ {x x}}{l _ {y y}} = r ^ {2}
$$

决定系数 $r^2$ ，表示r的变异中有多少是X造成的。如 $r^2 = 1$ ，则Y的变异完全由X所造成。

作直线相关分析时还须注意。$\textcircled{1}$应用相关系数下结论之前，必须经过统计上的假设检验，如拒绝接受 $\beta = 0$ 的假设，才能得出X、Y之间相关的结论。$\textcircled{2}$相关系数有显著性说明X、Y之间有直线相关，并不证明两者有因果关系。

相关分析的步骤：

(1) 将对的数据列出（如例中的表），绘制散点图，用目测方法观察是否呈直线趋势。呈直线趋势的数据，适应相关分析。

(2) 计算XY的离均差平方和及离均差乘积之和， $ \mathrm{l_{XY}}=\sum(\mathrm{X}-\bar{\mathrm{X}})^{2},\mathrm{l_{YY}}=\sum(\mathrm{Y}-\bar{\mathrm{Y}})^{2},\mathrm{l_{XY}}=\sum(\mathrm{X}-\bar{\mathrm{X}})(\mathrm{Y} $

- $ \bar{\mathrm{Y}} $

(3) 按式（1）计算出相关系数 $ r $。

(4) 作相关系数假设检验。原假设为 $\rho = 0$ 。 $\rho$ 为这总体的相关系数。如果检验结果拒绝接受原假设，则可认为XY两变量之间存在直线相关关系。否则，不能下两者有相关的结论。

检验方法为用下式计算t值：

$$
t = \frac {r}{\sqrt {\left(1 - r ^ {2}\right) / (n - 2)}}, \text {自 由 度} = n - 2
$$

此值与 $t_{0.05(n - 2)}$ 相比，如 $t > t_{0.05(n - 2)}$，则 $P < 0.05$，拒绝接受 $\beta = 0$ 的原假设。否则，不能拒绝接受。

现已制备相关系数界限值表（附录四表40），查表可得P=0.05时的r界限值，样本的r值与i相比，如大于界限值，表示拒绝 $\rho = 0$ 的原假设。

r值的假设检验与b值的假设检验是等价的，也即表示结论是一致的。一个样本用r值作假设检验已有结论，可不必再作b的假设检验，反之亦然。

例 用一种乳粉饲养10只大白鼠，增进贪食量 $(X, g)$ 和增加体重 $(Y, g)$ 的记录如下表。求出X、Y之间相关系数，并作原假设为 $\rho = 0$ 的假设检验。

<div align="center">

表 10只大白鼠的进食量X和增重Y

</div>

<table><thead><tr><th></th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th><th>6</th><th>7</th><th>8</th><th>9</th><th>10</th></tr></thead><tbody><tr><td>X</td><td>820</td><td>780</td><td>720</td><td>867</td><td>690</td><td>787</td><td>934</td><td>679</td><td>639</td><td>820</td></tr><tr><td>Y</td><td>165</td><td>158</td><td>130</td><td>180</td><td>134</td><td>167</td><td>180</td><td>145</td><td>120</td><td>158</td></tr></tbody></table>

(1) 作散点图，可看出X、Y之间呈直线趋向.

(2) 计算相关系数 $ r_{i} $

$$
\begin{array}{l} \bar {X} = 7 7 3. 6, \bar {Y} = 1 5 4. 3 \\ \sum \left(X - \bar {X}\right) ^ {2} = 7 5 9 0 6. 4, \sum \left(Y - \bar {Y}\right) ^ {2} = 4 2 3 4. 1 \\ z \left(X - \bar {X}\right) \left(Y - \bar {Y}\right) = 1 6 8 4 3. 2 \\ r = \frac {\sum \left(X - \bar {X}\right) \left(Y - \bar {Y}\right)}{\sqrt {\sum \left(X - \bar {X}\right) ^ {2} \sum \left(Y - \bar {Y}\right) ^ {2}}} = \frac {1 6 8 4 3 . 2}{\sqrt {7 5 9 0 6 . 4 \times 4 2 3 4 . 1}} = 0. 9 3 9 5 \\ \end{array}
$$

(3) $ \mathrm{H}_{2}:\rho=0, \mathrm{H}_{1}:\rho\neq0。 $

$$
t = \frac {r}{\sqrt {\left(1 - r ^ {2}\right) / (n - 2)}} = \frac {0 . 9 3 9 5}{\sqrt {\left(1 - 0 . 9 3 9 5 ^ {2}\right) / 8}} = 7. 7 6
$$

自由度 $= n - 2 = 8$

(4) 判断：查 t值表(表录四表15)， $ t_{0.05} = 2.306, p < 0.05 $ ，拒绝原假设，接受备择假设。说明代乳粉的进入量与增加体重有显著相关。

## 相关系数比较

相关系数比较(comparison among correlation coefficients)包括一个样本相关系数与已知总体相关系数 $p$ 的比较，两个或二个以上样本相关系数之间的比较。如从同一个总体中抽取多个样本，样本相关系数 $r$ 的分布，呈一个偏态分布。总体相关系数 $p$ 的绝对值高于0值越远（越接近于1），则 $r$ 值分布偏度越大。如将 $r$ 值作Z变

换（ $ \dot{Z} $ transformation)，则Z值分布接近正态。 $ \dot{Z} $变换的公式为

$$
\begin{array}{l} \dot {Z} = \frac {1}{2} \ln \frac {1 + r}{1 - r} \\ \dot {Z} = \tanh ^ {- 1} r \\ \end{array}
$$

或

样本r变换为 $ \hat{Z} $值后，其标准差为

$$
s _ {2} = \frac {1}{\sqrt {n - 3}}
$$

Z变换又称反双曲线正切变换。Z分布接近正态分布。因此，相关系数之间的比较可采用Z检验或 $x^{2}$ 检验。

(1) 样本 $ \mathrm{r}_{1} $与已知总体 $ \rho $比较：计算Z值（Z检验的统计量）：

$$
Z = \frac {\dot {Z} _ {1} - \dot {Z}}{\sqrt {1 / \left(n _ {1} - 3\right)}} = \left(\dot {Z} _ {1} - \dot {Z}\right) \sqrt {n _ {1} - 3}
$$

$n_2$ 为样本中（X、Y）数， $Z$ 为已知总体 $p$ 的 $Z$ 变换值。

(2) 两个r的比较：计算z值，如大于1.96，则 $ \rho<0.05。 $

$$
z = \frac {\dot {Z} _ {1} - \dot {Z} _ {2}}{\sqrt {\frac {1}{n _ {1} - 3} + \frac {1}{n _ {2} - 3}}}
$$

(3) 多个r的比较：计算 $ X^{2} $

$$
X ^ {2} = \sum_ {i = 1} ^ {k} \left(\frac {\dot {Z} _ {i} - \dot {Z} _ {w}}{1 / \sqrt {n _ {i} - 3}}\right) ^ {2} = \sum_ {i = 1} ^ {k} \left(n _ {i} - 3\right) \left(\dot {Z} _ {i} - \dot {Z} _ {w}\right) ^ {2}
$$

自由度=k-1

$ \dot{Z}_{w} $为各 $ \dot{Z}_{1} $的加权平均：

$$
\dot {Z} _ {w} = \frac {\sum_ {i} \left(n _ {i} - 3\right) z _ {i}}{\sum_ {i} \left(n _ {i} - 3\right)}
$$

如果在两个或多个k比较时，假设检验结果为无显著差别，可用式（6）计算合并相关系数的 $Z_{w}$ 值，它的标准差 $Z_{w}$ 用下式计算：

$$
\mathrm {s} \dot {z} _ {w} = \frac {1}{\sqrt {\sum_ {i} \left(n _ {i} - 3\right)}}
$$

95%的可信限为

$$
\dot {Z} _ {\mathrm {w}} \pm 1. 9 6 \mathrm {s} _ {\mathrm {z w}} 。
$$

Z值可用下式变换为相关系数：

$$
r = \left(e ^ {2 2} - 1\right) / \left(e ^ {2 2} + 1\right)
$$

例 某人测定20个2岁儿童的身高和心影面积，得到相关系数为0.88.问该样本相关系数是否来自 $\rho = 0.5$ 的总体？

$$
\mathrm {H} _ {0}: \rho = 0. 5;
$$

$$
\mathrm {H} _ {2}: \rho \neq 0. 5,
$$

作Z变换，今 $ r=0.88 $

$$
\dot {Z} _ {r} = \frac {1}{2} \ln \frac {1 + r}{1 - r} = \frac {1}{2} \ln \frac {1 . 8 8}{0 . 1 2} = 1. 3 8
$$

$$
\dot {Z} _ {c} = \frac {1}{2} \ln \frac {1 + r}{1 - r} = \frac {1}{2} \ln \frac {1 . 5}{0 . 5} = 0. 5 5
$$

$$
\text {则} Z = \frac {\hat {Z} _ {\mathrm {r}} - \hat {Z} _ {\mathrm {c}}}{\sqrt {1 / (n - 3)}} = \frac {1 . 3 8 - 0 . 5 5}{\sqrt {1 / 1 7}} = 3. 4 2
$$

因为 $Z = 3.42 > 1.96, \rho < 0.05$ ，说明2岁儿童身高和心影面积的相关系数不是来自 $\rho = 0.5$ 的总体。

组内相关系数(correlation coefficient within group)是用作X、Y成对数据不必分清何者为X，何者为Y时的相关指标，如作为表示同胞、双生子间某种特征相似程度的测量。从同胞、双生子测得的某种特征的一对数值，分哪一个是自变量X，哪一个是应变量Y是不必要的。

## 组内相关系数

在计算内相关系数时，先要作一个方差分析。用一般方差分析方法计算出组间均方和组内均方，分别用MS组间和MS组内表示。

根据下一公式计算出组内相关系数n:

$$
n = \frac {\mathrm {M S} (\text {组间}) - \mathrm {M S} (\text {组内})}{\mathrm {M S} (\text {组间}) + \left(n _ {0} - 1\right) \mathrm {M S} (\text {组内})}
$$

$ \mathrm{n}_{0} $为同胞（或双生子、多生子）数，双生子时 $ \mathrm{n}_{0} $为2。

n的显著性检验就是一般单因素方差分析中的F检验。

组内相关系数可用于双生子的遗传学研究

例 8 对双生子的身高见表，试用组内相关系数表示兄弟之间身高的相关程度。

<div align="center">

8对双生子的身高（cm）

</div>

<table><thead><tr><th rowspan="2">对数</th><th colspan="2">双生子中</th><th rowspan="2">和</th></tr><tr><th>第一个</th><th>第二个</th></tr></thead><tbody><tr><td>1</td><td>87</td><td>85</td><td>172</td></tr><tr><td>2</td><td>88</td><td>96</td><td>184</td></tr><tr><td>3</td><td>89</td><td>95</td><td>184</td></tr><tr><td>4</td><td>84</td><td>89</td><td>173</td></tr><tr><td>5</td><td>100</td><td>105</td><td>205</td></tr><tr><td>6</td><td>79</td><td>88</td><td>167</td></tr><tr><td>7</td><td>87</td><td>91</td><td>178</td></tr><tr><td>8</td><td>96</td><td>100</td><td>196</td></tr><tr><td>Σ</td><td></td><td></td><td>1 459</td></tr><tr><td></td><td></td><td></td><td>X̄ = 91.1875</td></tr></tbody></table>

(1) 计算总离均差平方和SS是

$$
\mathrm {S S} _ {\mathrm {R}} = \sum X ^ {2} - (\sum X) ^ {2} / 1 6 = \left(8 7 ^ {2} + 8 8 ^ {2} + \dots + 9 1 ^ {2} + 1 0 0 ^ {2}\right)
$$

(2) 先计算组间离均差平方和SS组间，再计算组间均方 MS组间；

$$
- (1 4 5 9) ^ {2} / 1 6 = 7 1 0. 4 3 7 5
$$

$$
\mathrm {S S} _ {\text {组 间}} = \left(1 7 2 ^ {2} + 1 8 4 ^ {2} + \dots + 1 7 8 ^ {2} + 1 9 6 ^ {2}\right) \div 2 - \frac {(1 4 5 9) ^ {2}}{1 6}
$$

$$
- 5 7 6. 9 3 7
$$

$$
\mathrm {M S} _ {\mathrm {组 间}} = 5 7 6. 9 3 7 5 / 7 = 8 2. 4 2
$$

(3) 先计算组内离均差平方和SS组内，再计算组内均方 MS组内：

$$
\mathrm {S S} _ {\mathrm {组 内}} = \mathrm {S S} _ {\mathrm {总}} - \mathrm {S S} _ {\mathrm {组间}} = 7 1 0. 4 3 7 5 - 5 7 6. 9 3 7 5 = 1 3 3. 5
$$

$$
\mathrm {M S} _ {\mathrm {组 内}} = 1 3 3. 5 / 8 = 1 6. 6 8 7 5
$$

(4) 计算 $ \mathbf{r}_{1} $

$$
r _ {1} = \frac {8 2 . 4 2 - 1 6 . 6 8 7 5}{8 2 . 4 2 + 1 6 . 6 8 7 5} = \frac {6 5 . 7 3 2 5}{9 9 . 1 0 7 5} = 0. 6 6 3 2
$$

组内相关系数为0.66，说明双生子之间的身高相似程度。如将双生子分清同卵、异卵，则更能分清同卵双生子或异卵双生子之间的相关程度。

## 等级相关

等级相关(rank correlation)是等级资料的直线相关分析，是分析成对数据当一个变量变化时（如上升时）另一个变量是否有随之单纯上升或下降趋势关系的一种统计方法。它是一种非参数统计方法，类似参数性统计中的线性相关方法。

非参数性统计中分析相关问题有Spearman等级相关和Kendall等级相关。两者分别用不同的统计量表达两变量之间关系的性质（方向）和程度，分别用 $r_{\mathrm{S}}$ （Spearman等级相关系数）和 $r_{\mathrm{Kend}}$ （Kendall等级相关系数）代表。$r_{\mathrm{S}}$、$r_{\mathrm{K}}$ 的数值在-1与1之间，当小于0时表示负相关，大于0时表示正相关，绝对值越接近1表示相关程度越密切。分析时，应作假设检验，有显著性时才下两个变量有相关的结论。同一个样本计算 $r_{\mathrm{S}}$ 和 $r_{\mathrm{K}}$，两者的数值是相近而不相等。作假设检验时，$\alpha = 0.05$ 临界值的数值也不同。

适宜用直线相关方法分析的数据，均可用上述非参数统计方法分析。当成对数据中两个变量不呈双态量正态分布时，或分布不明时，不宜用直线相关系数r的方法分析，而可用r<sub>s</sub>或r<sub>s</sub>进行分析。当X、Y两个变量中有一个是等级数据，也宜用r<sub>s</sub>或r<sub>s</sub>作分析。

## Spearman等级相关

(1) 编秩次：将成对的数据中两种变量分别按其数值大小编秩次。遇有相同的数值，给以平均秩次。每遇到的相同秩次的观察值，记下其个数，以 $t_{1}$ 代表。i表示有相同秩次的组数。例如第一次遇到相同秩次的观察值有3个，记 $t_{1} = 3$，第二次有4个，记 $t_{2} = 4$。

(2) 计算每对X、Y的秩次的差值 $ \mathrm{d}。 $

(3) 计算 $ \mathrm{r}_{s} $

$$
r _ {s} = 1 - \frac {6 \sum d ^ {2}}{(n - 1) n (n + 1)} = 1 - \frac {6 \sum d ^ {2}}{n \left(n ^ {2} - 1\right)}
$$

n为样本有多少个对子。

(4) 有相同秩次时，计算“纠正 $ \mathrm{r}_{s} $”代表 $ \mathrm{r}_{s} $：

纠正 $r_{s} = \frac{(n^{3} - n) / 6 - (T_{x} + T_{y}) - \sum d^{2}}{\sqrt[(n^{3} - n) / 6 - 2T_{x}][(n^{3} - n) / 6 - 2T_{y}]}$ (2)

$T_{x} = \sum_{i=1}^{k} \left(t_{i}^{3} - t_{i}\right) / 12, k$ 为变量中相同秩次的组数，每组的相同秩次变量有 $t_{i}$ 个； $T_{y}$ 为 $y$ 变量中相应数值。

对 $r_{\mathrm{s}}$ 或纠正 $r_{\mathrm{s}}$ 可查附录四表41中 $p = 0.05$ 的 $r_{\mathrm{s}}$ 界限值，如 $r_{\mathrm{s}} > r_{\mathrm{s}}(0.05)$，表示可拒绝两变量不相关的假设。

如n很大， $ \mathrm{r_s} $值与r值十分相近。假设检验可采用自由度n-2的r值的t检验方法（见“直线相关”条）。

例1 8名2岁男童的体重与心影面积数据如表1，试计算 $ \mathbf{r}_{s0} $

<div align="center">

表1 8名儿童的体重与心影面积

</div>

<table><thead><tr><th>体重(kg)<br>X</th><th>秩次</th><th>心影面积<br>(cm²)<br>Y</th><th>秩次</th><th>d</th><th>d²</th></tr></thead><tbody><tr><td>9</td><td>1</td><td>29.2</td><td>1</td><td>0</td><td>0</td></tr><tr><td>10</td><td>2.5</td><td>33.5</td><td>2</td><td>0.5</td><td>0.25</td></tr><tr><td>10</td><td>2.5</td><td>40.4</td><td>6</td><td>-3.5</td><td>12.25</td></tr><tr><td>12</td><td>5</td><td>35.4</td><td>3</td><td>2</td><td>4</td></tr><tr><td>12</td><td>5</td><td>37.7</td><td>4</td><td>1</td><td>1</td></tr><tr><td>12</td><td>5</td><td>39.4</td><td>5</td><td>0</td><td></td></tr><tr><td>13</td><td>7</td><td>46.7</td><td>8</td><td>-1</td><td>1</td></tr><tr><td>15.5</td><td>8</td><td>41.3</td><td>7</td><td>1</td><td>1</td></tr><tr><td></td><td></td><td></td><td></td><td></td><td>19.5</td></tr></tbody></table>

$$
T _ {x} = \frac {\left(2 ^ {3} - 2\right) + \left(3 ^ {3} - 3\right)}{1 2} = \frac {6 + 2 4}{1 2} = \frac {3 0}{1 2} = 2. 5
$$

$$
r _ {s} = 1 - \frac {6 (1 9 . 5)}{8 \left(8 ^ {2} - 1\right)} = 0. 7 7
$$

纠正 $ \mathrm{r}_{\mathrm{s}}=\frac{(8^{3}-8)/6-5-19.5}{\sqrt{[(8^{2}-8)/6-2\times 30/12][(8^{2}-8)/6]}}=\frac{595}{\sqrt{79\times 84}}. $ $ =0.72 $

查附录四表41,n=8,p<0.05。

这一结果表示儿童的心影面积与体重之间有相关。

## Kendall等级相关

(1) 将原始的成对数据，按X值的大小，从小到大为序列出，同时将相应的Y值列于其旁。当X有相同数值时，相应的Y值从小到大列于其旁。

(2) 对此n对数据中的每一个Y值，往下点算出大于此值的Y有n个（等于或小于此值不计），其和记为s。

(3) 计算 $ \mathbf{r}_{k} $

$$
r _ {k} = \frac {4 s}{n (n - 1)} - 1
$$

n为数据中的对子数。

当X、Y有相同值时，用下式计算校正 $ r_{k} $

校正 $r_{\mathrm{k}} = \frac{2\mathrm{s}}{\sqrt{\left(\mathrm{n}^{2} - \mathrm{n}\right) / 2} - \mathrm{U}_{\mathrm{x}}\sqrt{\left(\mathrm{n}^{2} - \mathrm{n}\right) / 2} - \mathrm{U}_{\mathrm{Y}}} - 1$ (4)式中 $\mathrm{U}_{\mathrm{x}} = \sum_{i=1}^{k}\left(t_{i}^{2} - t_{i}\right) / 2$ k为X变量中有多少组有相同数值，i组相同值变量有 $t_{i}$ 个； $\mathrm{U}_{\mathrm{Y}}$ 为Y变量中相应数值。

(4) 作假设检验。原假设为当 $X$ 小从大排列时，Y为随机排列。检验方法是查 $\alpha = 0.05$ 的 $r_{\mathrm{k}}$ 临界值表（附录四表44）。当 $r_{\mathrm{k}}$ 于临界值，说明有显著性。

例2 8名2岁男童的体重与心影面积如表2列，试计算 $ \mathrm{r_k}。 $

<div align="center">

表2 8名儿童的体重与心影面积

</div>

<table border="1"><tr><td>体重X(kg)</td><td>心影面积Y(cm2)</td><td>向下计算＞Y的个数</td></tr><tr><td>9</td><td>29.2</td><td>7</td></tr><tr><td>10</td><td>33.5</td><td>6</td></tr><tr><td>10</td><td>40.4</td><td>2</td></tr><tr><td>12</td><td>35.4</td><td>4</td></tr><tr><td>12</td><td>37.7</td><td>3</td></tr><tr><td>12</td><td>39.4</td><td>2</td></tr><tr><td>13</td><td>46.7</td><td>0</td></tr><tr><td>15.5</td><td>41.3</td><td>0</td></tr><tr><td>t1=2</td><td></td><td>s=24</td></tr><tr><td>t2=3</td><td></td><td></td></tr></table>

$$
r _ {k} = \frac {4 s}{n (n - 1)} - 1 = \frac {4 \times 2 4}{8 (8 - 1)} - 1 = 0. 7 1 4
$$

$$
\begin{array}{l} \text {纠 正} k _ {\mathrm {r}} = \frac {2 s}{\sqrt {[ n (n - 1) ] / 2 - U _ {x} ] [ n (n - 1) / 2 - U _ {y} ]} - 1} \\ = \frac {2 \times 2 4}{\sqrt {\frac {8 \times 7}{2} - \frac {(4 - 2) + (9 - 3)}{2}} \left[ \frac {8 \times 7}{2} \right]} - 1 \\ = 1. 8 5 - 1 = 0. 8 5 \\ \end{array}
$$

含附录四表44，得 $ p < 0. 0 5 $ ，说明儿童体重与心影面积呈正相关。

## 列联系数

列联系数(contigency coefficient)是测定两个定性（或半定量）变量之间相关关系强度的一种指标。

两个定性变量之间有相关关系，只要对两个变量不同水平组成的四格表或 $r \times c$ （r为行数，c为列数）列联表进行一般 $\chi^2$ 检验。如要对联系程度作出衡量，则需用列联系数。最常用的列联系数是Pearson列联系（cc），它以下式为定义：

$$
c c = \sqrt {\frac {x ^ {2}}{n + x ^ {2}}}
$$

cc的值介于0到1之间，cc的值越大，表示相应两个变量间的相关关系越密切。但是cc的取值受到列联表大小的影响，对于四格表（即 $2\times 2$ 表），cc的取值 $\leqslant \sqrt{\frac{2 - 1}{2}} = 0.707$；对于 $3\times 4$ 表，cc的取值 $\leqslant \sqrt{\frac{3}{1}} = 0.817$；一般 $r\times c$ 表（设 $r\leqslant c$），cc的取值 $\leqslant \sqrt{\frac{r - 1}{r}}$。所以不同大小列联表的cc不能相互比较，这是cc的缺点。为了

各种不同大小的列联表相互比较，可用下式计算纠正列联系数：

$$
\text {纠 正} \mathrm {c c} = \frac {\mathrm {c c}}{\mathrm {c c} (\text {最 大 值})} = \frac {\mathrm {c c}}{\sqrt {\frac {\mathrm {r} - 1}{\mathrm {r}}}}
$$

例 粮库工人接触谷尘有谷物热史者27人为观察组，年龄性别与之相仿无接触史工人27人对照组，两组工人血清总免疫球蛋白E(qE)水平见下表。 $x^{2} = 8.36$ ， $p < 0.01$ ，计算Pearson列联系数（cc）。

从上表，得 $n = 54,r = 2.$ $\chi^2$ 值为8.36。则

$$
c c = \sqrt {\frac {8 . 3 6}{5 4 + 8 . 3 6}} = 0. 3 6 6
$$

$$
\text {纠 正} \mathrm {c c} = \frac {\mathrm {c c}}{\sqrt {\frac {\mathrm {r} - 1}{\mathrm {r}}}} = \frac {0 . 3 6 6}{\sqrt {1 / 2}} = 0. 5 1 8
$$

<div align="center">

两组工人血清总IgE水平（IU/ml）

</div>

<table><thead><tr><th rowspan="2"></th><th colspan="3">血清总IgE水平</th><th rowspan="2">合 计</th></tr><tr><th>&lt;500</th><th>500-</th><th>5000-</th></tr></thead><tbody><tr><td>观察组</td><td>11</td><td>10</td><td>6</td><td>27</td></tr><tr><td>对照组</td><td>21</td><td>5</td><td>1</td><td>27</td></tr></tbody></table>

## 曲线回归

## 曲线回归

曲线回归(curvilinear regression)又称非线性回归(non-linear regression)，是自变量与应变量之间不呈直线关系时的统计描述与分析方法。

曲线回归中的模型或称非线性模型，用来拟合不呈直线关系的数据。非线性模型有很多种，选择模型最基本的要求是曲线形状与数据在直角坐标上各点的连线形状相一致。

非线性模型种类 医学上常用的非线性模型有下列数种（F式中X,Y为变量,e为自然对数的底,其余字母均为待估计的参数）。

(1) 多项式曲线：

$$
\begin{array}{l} Y = a + b _ {1} X + b _ {2} X ^ {2} \\ Y = a + b _ {1} X + b _ {2} X ^ {2} + b _ {3} X ^ {3} \\ \end{array}
$$

(2) 指数曲线：

$$
\begin{array}{l} \mathrm {Y} = \mathrm {a e} ^ {\mathrm {b x}} \\ \mathrm {Y} = \mathrm {a e} ^ {- \mathrm {b x}} \\ \mathrm {Y} = \mathrm {k} - \mathrm {a e} ^ {\mathrm {b x}} \\ \mathrm {Y} = \mathrm {k} - \mathrm {a e} ^ {- \mathrm {b x}} \\ \end{array}
$$

(3) logistic曲线

$$
\begin{array}{l} Y - L = \frac {k}{1 + a e ^ {b x}} \\ Y - L = \frac {k}{1 + a e ^ {- b x}} \\ \end{array}
$$

式中k和L为根据曲线位置而选定的参数。

(4) 对数曲线：

$$
\begin{array}{l} Y = a + b \log X \\ \log Y = a + b X \\ \end{array}
$$

![](page=21,bbox=[492, 653, 774, 772])

![](page=21,bbox=[490, 771, 759, 893])

![](page=21,bbox=[486, 905, 788, 1024])

![](page=21,bbox=[489, 1033, 751, 1143])

<div align="center">

非线性模型

</div>

模型的选择 有以下几种：

(1) 根据X、Y两种变量关系的性质来选择模型。例如，X增加时Y值呈几何级数增加（在医学中例子有：X为时间，Y为培养基内微生物浓度）宜用 $Y = ae^{bX}$ 型模型X增加时，Y按固定比例下降，如X为时间，Y为体内某毒物的浓度，宜用 $Y = ae^{-bX}$ 型

(2) 将实际数据在直角纸上绘制点图，根据图形选择曲线模型，进行试配，也可根据拟合度的优劣来选择。现代计算计技术为这提供了条件。

(3) 通用性比较强的是多项式曲线模型，它对任何曲线都可作为拟合的模型。一般有一个峰，呈抛物线曲线图形，用X的一次项的多项式曲线可作适当的拟合。更多峰的曲线用X的高次项，适合程度较好

曲线回归方法应用（1）确定X、Y之间的关系。对X、Y之间的数学联系的描述更接近实际数据（与直接回归模型相比），回归式可用作修匀手段，使X、Y关系消除误差因素，表达更为清晰。

(2) 从X值预测或推算出应变量Y值.

(3) 找出对Y作用最大的X值，或作用最小的X值。

(4) 找出对Y变化最大的X值，或在某X值时的变化速度。

(5) 像直线回归一样， $(\mathrm{Y} - \bar{\mathrm{Y}})$ 值，即残差值可认为消除X因素后Y的随机观察误差。此值可用于进一步分析。例如，分析除X外，是否还有其他重要的自变量对Y起作用。

## 曲线拟合

曲线拟合（curve fitting)是对研究中得到的成对数据(X、Y)用曲线回归方程式表达其相互联系的统计处理技术。如果把成对的观察值点在以X为横坐标、Y为纵坐标的坐标纸上，各点不呈直线趋向时，宜用曲线回归方程作处理。

## 曲线拟合步骤：

选择一个合适的曲线模型 根据观察值点在坐标纸上所呈现的曲线形状，结合专业知识和经验，选择适当的模型。例如，应变量Y为一百分值，不能超过 $100\%$ 。

估计参数 在模型决定之后，可有两类拟合方法来估计模型参数。

(1) 直线化变换方法。这方法将曲线模型中变量X、Y，通过适当的变换得新变量x，y，使x，y之间呈直线关系，从而可用直线回归方法得到参数估计值，再变换回来得到描述这数据的曲线回归方程式。

以指数曲线模型为例，Y = ae$^{bx}$，等式两侧各取自然对数值，得 $\ln Y = \ln a + bX$，将Y作y = $\ln Y$，x = X变换，得y = $\ln a + bx$，这是一个直线回归模型。将原数据(X、Y)，全部变换为(x, y)值，用一般直线回归方法求出b与 $\ln a$；

$$
\begin{array}{l} b = \left[ \sum (x - x) (y \cdot \bar {y}) \right] / \sum (x - \bar {x}) ^ {2} \\ \ln a = y b \bar {x} \\ \text {得} a = e ^ {\bar {y}} b ^ {3} \\ \end{array}
$$

求出a,b，即得 $ Y=a\mathrm{e}^{b\mathrm{x}} $的曲线回归方程式。

以二次多项式回归模型， $ \mathrm{Y}=\mathrm{a}-\mathrm{b}_{1}\mathrm{X}+\mathrm{b}_{2}\mathrm{X}^{2} $为例，使新变材 $ \mathrm{x}_{1}=\mathrm{X},\mathrm{x}_{2}=\mathrm{X}^{2} $，即得多元线性回归模型：

$$
Y = a + b _ {1} x _ {1} + b _ {2} x _ {2}
$$

$\mathrm{x}_{1},\mathrm{x}_{2}$ 为两个新自变量，通过“法方程式”，并将新变量换回原变量，可解出a， $b_{1},b_{2}$：

$$
\mathrm {a n} + \mathrm {b} _ {1} \sum \mathrm {X} + \mathrm {b} _ {2} \sum \mathrm {X} ^ {2} = \sum \mathrm {Y}
$$

$$
a \sum X + b _ {1} \sum X ^ {2} + b _ {2} \sum X ^ {3} = \sum X Y
$$

$$
a \sum X ^ {2} + b _ {1} \sum X ^ {3} + b _ {2} \sum X ^ {4} = \sum X Y
$$

上式中，n为样本含量，X为原变量。

(2) 直接估计曲线回归方程式的参数。有极大似然法等参数估计方法可估计出回归方程式中各个参数。以 $Y = a + b_{1}X + b_{2}X^{2}$ 为例，Y的分布为 $\frac{1}{\sqrt{2}\pi \sigma^{2}} 2^{1} \sigma^{2} (Y - Y)^{2}$ 似然函数为 $\frac{1}{(2\pi \sigma^{2})^{N / 2}} \exp \left[ -\frac{1}{2} \sigma^{2} \sum (X - a - X b; -X^{2} b_{2})^{2} \right]$

对数似然函数为

$$
L = \sum^ {n} \left(Y _ {1} - a - b _ {1} X _ {1} - b _ {2} X _ {1} ^ {2}\right) ^ {2}
$$

使 $\frac{\partial L}{\partial a}, \frac{\partial L}{\partial b}, \frac{\partial L}{\partial b_2}$ 等于0，得到求a， $b_{1}, b_{2}$ 的方程式。

除多项式之外，一般曲线模型的直线化法与直接估计数方法，得出的参数值不是完全相同的，直接用最大似然法较好。但直线化方法运算方便，仍是普遍接受的方法。

求估计值，作曲线图。从拟合的曲线回归方程，求出估计值 $\vec{V}$，作曲线图。约略观察所拟合的曲线与实际数据符合情况。必要时作拟合优度检验，计算非线性决定系数，表示拟合程度。

曲线拟合的实际应用，类似直线问题，如用于修匀，从自变量X推算应变量Y。也可计算不同水平X值每增加一个单位值时，Y值应增加值。并可计算X在什么数值时，Y值为最大或最小。

## 指数曲线拟合

指数曲线拟合(exponential curve fitting)是利用指数函数拟合双变量实测数据，即当自变量X增大时，应变量Y随之呈几何级数增加（或减少）的一类曲线的拟合。用拟合指数曲线方程可以分析两变量之间的关系。在卫生学领域中，常用指数曲线描述生长过程，并称其为指数生长曲线。

指数函数的一般形式为

$$
Y = a c ^ {b x}
$$

或

$$
k - Y = a c ^ {b X}
$$

其中c为任意常数，通常取 $ c=e_{\mathrm{c}} $

拟合指数曲线时，可按下式求得曲线方程中的a和b：

$$
b = \frac {\sum (X y) - \frac {(\sum X) (\sum Y)}{n}}{\sum X ^ {2} - \frac {(\sum X) ^ {2}}{n}}
$$

<div align="center">

表1 年龄与高血压患病率的指数曲线配合计算表

</div>

<table><thead><tr><th>年龄组 (1)</th><th>X (2)</th><th>X² (3)</th><th>Y(%) (4)</th><th>y = lnY (5)</th><th>y² (6)</th><th>Xy (7)</th><th>Y = 0.340 69 e⁰·⁷⁴⁹⁹ (8)</th></tr></thead><tbody><tr><td>15-</td><td>17.5</td><td>306.25</td><td>0.78</td><td>-0.248 5</td><td>0.061 7</td><td>-4.348 1</td><td>1.287 9</td></tr><tr><td>20-</td><td>22.5</td><td>506.25</td><td>2.19</td><td>0.783 9</td><td>0.614 5</td><td>17.635 8</td><td>1.883 2</td></tr><tr><td>25-</td><td>27.5</td><td>756.25</td><td>2.17</td><td>0.774 7</td><td>0.600 2</td><td>21.305 8</td><td>2.753 7</td></tr><tr><td>30-</td><td>32.5</td><td>1 056.25</td><td>4.89</td><td>1.587 2</td><td>2.519 2</td><td>51.583 7</td><td>4.026 5</td></tr><tr><td>35-</td><td>37.5</td><td>1 406.25</td><td>5.15</td><td>1.639 0</td><td>2.686 3</td><td>61.462 4</td><td>5.887 6</td></tr><tr><td>40-</td><td>42.5</td><td>1 806.25</td><td>8.32</td><td>2.118 7</td><td>4.488 7</td><td>90.043 1</td><td>8.608 9</td></tr><tr><td>45-</td><td>47.5</td><td>2 256.25</td><td>13.38</td><td>2.593 8</td><td>6.727 6</td><td>123.463 0</td><td>12.588 0</td></tr><tr><td>50-55</td><td>52.5</td><td>2 756.25</td><td>18.49</td><td>2.917 2</td><td>8.510 2</td><td>153.154 6</td><td>18.406 3</td></tr><tr><td>合计</td><td>280</td><td>10 850</td><td>55.37</td><td>12.166 0</td><td>26.210 4</td><td>514.299 5</td><td></td></tr></tbody></table>

<div align="center">

表2 年龄与锡克试验阳性率指数曲线配合计算表

</div>

<table><thead><tr><th>年龄(X)<br>(1)</th><th>X²<br>(2)</th><th>锡克试验阳性率(Y)<br>(3)</th><th>100-Y<br>(4)</th><th>y=ln(100-Y)<br>(5)</th><th>y²<br>(6)</th><th>Xy<br>(7)</th><th>Ŷ=100-89.889 7c⁻⁰³²²ax<br>(8)</th></tr></thead><tbody><tr><td>1</td><td>1</td><td>29.44</td><td>70.56</td><td>4.256 5</td><td>18.117 8</td><td>4.256 5</td><td>34.857 1</td></tr><tr><td>2</td><td>4</td><td>52.72</td><td>47.28</td><td>3.856 1</td><td>14.869 5</td><td>7.712 2</td><td>52.791 1</td></tr><tr><td>3</td><td>9</td><td>68.98</td><td>31.02</td><td>3.434 6</td><td>11.796 5</td><td>10.303 8</td><td>65.787 8</td></tr><tr><td>4</td><td>16</td><td>76.96</td><td>23.04</td><td>3.137 2</td><td>9.842 0</td><td>12.548 8</td><td>75.206 5</td></tr><tr><td>5</td><td>25</td><td>81.34</td><td>18.66</td><td>2.926 4</td><td>8.563 8</td><td>14.632 0</td><td>82.032 2</td></tr><tr><td>6</td><td>36</td><td>86.34</td><td>13.66</td><td>2.614 5</td><td>6.835 6</td><td>15.687 0</td><td>86.978 7</td></tr><tr><td>7</td><td>49</td><td>90.53</td><td>9.47</td><td>2.248 1</td><td>5.054 0</td><td>15.736 7</td><td>90.563 5</td></tr><tr><td>28</td><td>140</td><td>486.31</td><td>213.69</td><td>22.473 4</td><td>75.079 2</td><td>80.877 0</td><td></td></tr></tbody></table>

$$
a = \ln^ {- 1} (\bar {y} - b X)
$$

其中 $y = \ln Y$ （当拟合曲线 $Y = ae^{bX}$ 时）；

$y = \ln (k - Y)$ （当拟合曲线 $k - y = ae^{bX}$ 时）。

例1 某局15—55岁男子各年龄组高血压患病率见表1（第1）、（4）栏，以各年龄组的中组为X，各年龄组患病率为Y用点图作初步观察（图1），可见X与Y可能呈指数曲线关系。试用指数曲线 $Y = ae^{bx}$ 拟合高血压年龄组患病率的变化趋势。

根据式（3）和式（4），

$$
b = - \frac {5 1 4 . 2 9 9 5 - \frac {2 8 0 \times 1 2 . 1 6 6}{8}}{1 0 8 5 0 - \frac {2 8 0 ^ {2}}{8}} = 0. 0 8 4
$$

$$
a = \ln^ {- 1} \left(\frac {1 2 . 1 6 6}{8} - 0. 0 8 4 \times \frac {2 8 0}{8}\right) = \ln^ {- 1} (- 1. 4 2 0) = 0. 2 4 2
$$

从而 $\hat{\mathrm{Y}} = 0.242\mathrm{e}^{\mathrm{i}\mathrm{D}.44\mathrm{x}}。$

根据表1，第(2)、(4)、(8)栏作图（图1）。

例 2 某地区不同年龄组组黑克试验阳性率见表 2 (表 3) 栏。初步用点图分析, 黑克试验阳性率 (Y) 与年龄 (X) 是指数曲线关系。按 $k - Y = ae^{bx}$ 作指数曲线拟合, 这里 $k = 100$, 因为阳性率 $Y$ 不会

![](page=23,bbox=[519, 811, 767, 1096])

<div align="center">

图1 某地15-55岁男性年龄与高血压患病率指数曲线超过 $100\%$ 。

</div>

根据式（3）和（4）

![](page=24,bbox=[64, 117, 367, 340])

<div align="center">

图2 年龄与锡克试验阳性率指数曲线

</div>

$$
b = - \frac {8 0 . 8 7 7 0 - \frac {2 8 \times 2 2 . 4 7 3 4}{7}}{1 4 0 - \frac {2 8 ^ {2}}{7}} = - 0. 3 2 2 0
$$

$$
\begin{array}{l} a - \ln^ {- 1} \left(\frac {2 2 . 4 7 3 4}{7} - (- 0. 3 2 2 0) \times \frac {2 8}{7}\right) = \ln^ {- 1} (4. 4 9 8 5) \\ = 8 9. 8 8 2 2 \\ \end{array}
$$

从而 $ \hat{Y}=1 0 0-8 9. 8 8 2 2 e^{-0. 3 2 2 0 x}。 $

根据表2第（1）、（3）、（8）栏作图（图2）。

## 对数曲线拟合

对数曲线拟合(logarithmic curve fitting)是利用对数函数来拟合双变量实测数据，并用拟合的对数曲线来描述两变量的关系的方法。

对数函数的一般形式为：

$$
Y = a + b \log_ {c} X
$$

其中 $c$ 为任意常数，当 $c = e$ 时，此对数为自然对数，上式为 $Y = a + b\ln X$，当 $c = 10$ 时，为常用对数，上式为 $Y = a!$ bigX。这是常用的两种对数曲线形式。

<div align="center">

IgG含量与沉淀环直径对载曲线配合计算表

</div>

<table border="1"><tr><td>IgG含量(X)(1)</td><td>x=lgX(2)</td><td>x2(3)</td><td>沉淀环直径(Y)(4)</td><td>Y2(5)</td><td>xY(6)</td><td>$\hat{\mathrm{Y}}=5.79617+5.31362\mathrm{lgX}$ (7)</td></tr><tr><td>0.875</td><td>-0.05799</td><td>0.00336</td><td>5.8</td><td>33.64</td><td>-0.33634</td><td>5.48802</td></tr><tr><td>1.75</td><td>0.24304</td><td>0.00591</td><td>7.1</td><td>50.41</td><td>1.72558</td><td>7.08758</td></tr><tr><td>3.5</td><td>0.54407</td><td>0.29601</td><td>8.6</td><td>73.96</td><td>4.67900</td><td>8.68740</td></tr><tr><td>5</td><td>0.69897</td><td>0.48856</td><td>9.4</td><td>88.36</td><td>6.71011</td><td>9.51023</td></tr><tr><td>7</td><td>0.84510</td><td>0.71412</td><td>10.2</td><td>104.04</td><td>8.62002</td><td>10.28670</td></tr><tr><td>10</td><td>1.00000</td><td>1.00000</td><td>10.9</td><td>118.81</td><td>10.90000</td><td>11.10979</td></tr><tr><td>12</td><td>1.07918</td><td>1.16463</td><td>11.3</td><td>127.69</td><td>12.19473</td><td>11.53053</td></tr><tr><td></td><td>4.35237</td><td>3.67259</td><td>63.3</td><td>596.91</td><td>44.49310</td><td></td></tr></table>

拟合对数曲线时，可按下式来求得曲线方程中的a和b：

$$
b = - \frac {\sum x Y - \frac {(\sum x) (\sum Y)}{n}}{\sum x ^ {2} - \frac {(\sum x) ^ {2}}{n}}
$$

$$
a = \bar {Y} - b \bar {x}
$$

其中 $x = \lg_{c} X_{c}$

例 某实验室在制作免疫球蛋白标准曲线中，测得IgG含量 $(\mu \mathrm{g})$ 与沉淀环直径(mm)7对数据，见表第(1)、(4)栏，切步点图分析，IG含量(X)与沉淀环直径(Y)可能呈对数曲线关系。试用对数曲线 $Y = a + b\lg X$ 来拟合。

$$
b = \frac {4 4 . 4 9 3 1 0 - \frac {4 . 3 5 2 3 7 \times 6 3 . 3}{7}}{3 . 6 7 2 5 9 - \frac {4 . 3 5 2 3 7 ^ {2}}{7}} = 5. 3 1 3 6 2
$$

$$
a = \frac {6 3 . 3}{7} - 5. 3 1 3 6 2 \times \frac {4 . 3 5 2 3 7}{7} = 5. 7 9 6 1 7
$$

$Y = 5.79617 + 5.31362x = 5.79617 + 5.31362\mathrm{lgX}$ 根据表(1)、(7)栏作图。

![](page=24,bbox=[509, 818, 793, 1090])

<div align="center">

图3 IgG含量与沉淀环直径对数曲线

</div>

IgG含量（X）与沉淀环直径（Y）之间联系用对数曲线描述，可认为合适，可从X值预测Y值大小

## 多项式曲线拟合

多项式曲线拟合(polynomial curve fitting)是对双变量实测数据用多项式曲线来拟合，以此描述两个变量间的关系，达到由一个变量预测或估算另一变量的目的。

多项式的一般形式为

$$
Y = a + b _ {1} X + b _ {2} X ^ {2} + b _ {3} X ^ {3} + \dots + b _ {m} X ^ {m}
$$

等式右侧只有第一、二项时，为直线方程，加上 $ \mathrm{b s} X^{2} $项为二次曲线方程，再加上 $ \mathrm{b s} X^{3} $项为三次曲线方程，余类推。

图1是常见的几种多项式曲线。（A）和（B）是二次多项式曲线，亦称二次抛物线。当 $b_{2} > 0$ 时有一极小点，$b_{2} < 0$ 时有一极大点。拟合所取的一段中也不包括极小点或极大点。（C）和（D）是三次多项式曲线，亦称三次抛物线。当 $b_{3} > 0$ 时，依次有一极大点和一极小点；$b_{3} < 0$ 时，

![](page=25,bbox=[560, 137, 753, 379])

<div align="center">

图1 几种常用的多项式曲线

</div>

依次有一极小点和一极大点；拟合所取的一段并非一定包括曲线的全部特征。（C）和（D）是三次多项式曲线的消退型，元极大点和极小点，只有一个拐点。

<div align="center">

素 pH值与蛋白凝固百分比抛物线配计算表

</div>

<table border="1"><tr><td>溶液pH值(X)(1)</td><td>X2(2)</td><td>X3(3)</td><td>X4(4)</td><td>蛋白凝固百分比(Ý)(5)</td><td>XÝ(6)</td><td>X2Ý(7)</td><td>Ý(8)</td></tr><tr><td>6.59</td><td>43.4281</td><td>286.191179</td><td>1885.99986961</td><td>44.1</td><td>290.619</td><td>1915.17921</td><td>42.58</td></tr><tr><td>6.83</td><td>46.6489</td><td>318.611987</td><td>2176.11987121</td><td>31.8</td><td>217.194</td><td>1483.43502</td><td>34.73</td></tr><tr><td>6.97</td><td>42.5809</td><td>338.608873</td><td>2360.10384481</td><td>31.2</td><td>217.464</td><td>1515.72408</td><td>31.012</td></tr><tr><td>7.09</td><td>50.2681</td><td>356.400829</td><td>2526.88187761</td><td>28.8</td><td>204.192</td><td>1447.72128</td><td>28.33</td></tr><tr><td>7.14</td><td>50.9796</td><td>363.994344</td><td>2598.91961616</td><td>26.8</td><td>191.352</td><td>1366.25328</td><td>27.34</td></tr><tr><td>7.25</td><td>52.5625</td><td>381.078125</td><td>2762.81640625</td><td>26.2</td><td>189.95</td><td>1377.13750</td><td>25.46</td></tr><tr><td>7.4</td><td>54.7600</td><td>405.224000</td><td>2998.65760000</td><td>24.8</td><td>183.52</td><td>1358.04800</td><td>23.530</td></tr><tr><td>7.68</td><td>58.9824</td><td>452.984832</td><td>3478.92350976</td><td>21.3</td><td>163.584</td><td>1256.32512</td><td>21.86</td></tr><tr><td>7.8</td><td>60.8400</td><td>474.552000</td><td>3701.50560000</td><td>22</td><td>171.600</td><td>1338.48000</td><td>21.92</td></tr><tr><td>7.96</td><td>63.3616</td><td>504.358336</td><td>4014.69235456</td><td>22.5</td><td>179.100</td><td>1425.63600</td><td>22.72</td></tr><tr><td>合计72.71</td><td>530.4121</td><td>3882.00450528</td><td>504.62054997</td><td>279.5</td><td>2008.575</td><td>14483.93949</td><td></td></tr></table>

随着多项式中X幂的升高，曲线形状亦越趋复杂。必要时，可采用逐步多项式回归，逐次增加其幂，至拟合最优时为止。但要注意，当按原始数据所作的观察点较少时，拟合多项式的幂也不能太高，否则由于自由度太小、曲线形状复杂而无实际意义。

多项式中的a值及各b值由下列方程组解得。

$$
\left\{ \begin{array}{c c c c c} \mathrm {n a} + & (\sum \mathrm {X}) \mathrm {b} _ {1} + \dots + (\sum \mathrm {X} ^ {\mathrm {m}}) \mathrm {b} _ {\mathrm {m}} = \sum \mathrm {Y} \\ (\sum \mathrm {X}) \mathrm {a} + & (\sum \mathrm {X} ^ {2}) \mathrm {b} _ {1} + \dots + (\sum \mathrm {X} ^ {\mathrm {m} - 1}) \mathrm {b} _ {\mathrm {m}} = \sum \mathrm {X Y} \\ \dots & \dots & \dots & \dots & \dots \\ (\sum \mathrm {X} ^ {\mathrm {m}}) \mathrm {a} + (\sum \mathrm {X} ^ {\mathrm {m} + 1}) \mathrm {b} _ {1} + \dots + (\sum \mathrm {X} ^ {2 \mathrm {m}}) \mathrm {b} _ {\mathrm {m}} = \sum \mathrm {X} ^ {\mathrm {m}} \mathrm {Y} \end{array} \right.
$$

二次抛物线过极小点（或极大点）有一对称轴，曲线两侧对称。令二次多项式的阶导数为0，可求得极小点

（或极大点）的X值：

$$
\begin{array}{l} b _ {1} + 2 b _ {2} X = 0 \\ X = - b _ {1} / 2 b _ {2} \\ \end{array}
$$

例 在研究尿素引起蛋白质变性要配度的影响的影响的资料中，实验记录了pH值与蛋白凝固百分比(%)，见表第(1)、(5)粒，初步用点图分析，pH值(X)与蛋白凝固百分比(Ý)呈抛物线关系。抛物线是二次曲线，即式(1)中 $m = 2$。试用抛物线 $\bar{Y} = a + b_{1}X + b_{2}X^{2}$ 拟合实测数据。

根据方程组（2）得到

$$
\left\{ \begin{array}{l} 1 0 a + 7 2. 7 1 b _ {1} + 5 3 0. 4 1 2 1 b _ {2} = 2 7 9. 5 \\ 7 2. 7 1 a + 5 3 0. 4 1 2 1 b _ {1} + 3 8 8. 0 0 4 5 0 5 b _ {2} = 2 0 0 8. 5 7 5 \\ 5 3 0. 4 1 2 1 a + 3 8 8. 0 0 4 5 0 5 b _ {1} + 2 8 5 0. 6 2 5 4 9 9 7 b _ {2} = 1 4 4 8. 9 3 9 4 9 \end{array} \right.
$$

解上方程组得：

$$
a = 9 8 3. 3 9 9 2 8 9, b _ {1} = - 2 4 8. 9 5 2 6 9 7 7, b _ {2} = - 1 6. 1 1 3 6 0 5 7
$$

从而有 $Y = 983.399289 - 248.9526977X + 16.1136057X^2$.

根据此式可计算出表1第(8)栏。

根据表中第（1）、（8）栏绘图（图2）。

![](page=26,bbox=[83, 211, 396, 454])

<div align="center">

图2 pH值与蛋白凝固百分比抛物线

</div>

从表和图可以看出，实际数据用抛物线拟合，可认为适合。如果此例选用含有更高幂的 $x$ 项；可使实际数据与此曲线更接近，但曲线形状随幂值增高而趋向形状复杂，不一定更能符合客观实际。

## 多项式曲线连续拟合

多项式曲线连续拟合(successive fitting of polynomials)是将同一数据从直线回归开始由低次到高次的一系列多项式曲线进行连续拟合，并对得到的一系列连续增加高幕项的多项式回归方程式按作拟合优度比较，直到优度不再显著才停止，然后选出一个合适的表示X、Y之间关系的多项式曲线。如m次多项式优度不再显著，则比m低一次，即(m-1)次多项式回归可认为表示X、Y间关系的回归式，其步骤如下：

(1) 将成对的X、Y数据，用一般方法计算出直线回归方程和二次、三次等多项式回归方程式：

$$
Y = a + b _ {1} X + b _ {2} X ^ {2} + \dots
$$

多项式曲线的拟合方法，见“多项式曲线拟合”条。

(2) 计算出各方程式的剩余平方和、先后两个方程式剩余平方和之差。

剩余平方和的计算方法是将每个X代入方程式得回归值 $\hat{\mathbf{Y}}$ ，用下式计算而得：

$$
\begin{array}{l} \mathrm {l} _ {\mathrm {Y} \cdot \mathrm {X}} = \sum \left(\mathrm {Y} - \hat {\mathrm {Y}}\right) ^ {2} \\ \mathrm {l} _ {\mathrm {(Y} \cdot \mathrm {X}) \mathrm {N}} = \sum \left(\mathrm {Y} - \hat {\mathrm {Y}} _ {1}\right) ^ {2} \\ \end{array}
$$

或

i代表多项式的次数。自由度为 $n - i - 1$ 。直线回归式中， $i = 1$ 。

先后两个多项式剩余平方和之差为：

$$
d _ {1} = l _ {(Y \cdot x) | - 1} - l _ {(Y \cdot x) |}, \text {自 由 度 为} 1
$$

当i为1，即 $ \mathrm{l}_{\mathrm{(Y \cdot X)}} $为直线回归中剩余平方和时， $ \mathrm{l}_{\mathrm{(Y \cdot X)}}-1 $

用 $ \mathrm{l}_{YY} $ ，即Y的离均差平方和代替。

(3) 将连续两个多项式剩余平方和之差 $ \mathrm{d}_{1} $作F检验或t检验。

$ \mathrm{H}_{0}:\delta=0。 $用下式计算F值：

$$
F = \frac {l _ {(y - x) i} - l _ {(y - x) i}}{l _ {(y - x) i} / (n - i - 1)}.
$$

将F与F $\alpha$ 相比较，得是否显著的结果。如在 $i = m$ 时不显著，采用m-1次的多项式回归。

例 某县血吸虫病疫区9岁以上人群皮内抗原试验阳性率调

合资料如表1.

<div align="center">

表1 各年龄组的血吸虫皮内抗原阳性率

</div>

<table><thead><tr><th>年 龄</th><th>组中值(X)</th><th>阳性率(Y)</th></tr></thead><tbody><tr><td>10—</td><td>12.5</td><td>2.904</td></tr><tr><td>15—</td><td>17.5</td><td>6.936</td></tr><tr><td>20—</td><td>22.5</td><td>12.833</td></tr><tr><td>25—</td><td>27.5</td><td>10.849</td></tr><tr><td>30—</td><td>32.5</td><td>19.225</td></tr><tr><td>35—</td><td>37.5</td><td>25.320</td></tr><tr><td>40—</td><td>42.5</td><td>37.802</td></tr><tr><td>45—</td><td>47.5</td><td>38.604</td></tr><tr><td>50—</td><td>52.5</td><td>35.535</td></tr><tr><td>55—</td><td>57.5</td><td>34.615</td></tr><tr><td>60—65</td><td>62.5</td><td>31.786</td></tr></tbody></table>

试确定一个适当次数的多项式。

(1) 用一般方法计算出直线回归方程式和二次、三次、四次多项式回归方程式（表2），得

<div align="center">

表2 从各多项式得到的回归值Y

</div>

<table><thead><tr><th>X</th><th>Y</th><th>$\hat{Y}_1$</th><th>$\hat{Y}_2$</th><th>$\hat{Y}_3$</th><th>$\hat{Y}_4$</th></tr></thead><tbody><tr><td>12.5</td><td>2.904</td><td>12.806</td><td>-0.727</td><td>4.151</td><td>4.134</td></tr><tr><td>17.5</td><td>6.936</td><td>18.060</td><td>6.471</td><td>5.496</td><td>5.512</td></tr><tr><td>22.5</td><td>12.833</td><td>20.030</td><td>12.872</td><td>9.295</td><td>9.312</td></tr><tr><td>27.5</td><td>10.849</td><td>23.642</td><td>18.476</td><td>14.737</td><td>14.740</td></tr><tr><td>32.5</td><td>19.225</td><td>27.254</td><td>23.284</td><td>21.007</td><td>20.997</td></tr><tr><td>37.5</td><td>25.320</td><td>30.867</td><td>27.294</td><td>27.294</td><td>27.778</td></tr><tr><td>42.5</td><td>37.802</td><td>34.479</td><td>30.508</td><td>32.284</td><td>32.773</td></tr><tr><td>47.5</td><td>38.604</td><td>38.163</td><td>32.925</td><td>36.664</td><td>36.667</td></tr><tr><td>52.5</td><td>35.55</td><td>41.702</td><td>34.544</td><td>38.121</td><td>38.138</td></tr><tr><td>57.5</td><td>34.615</td><td>45.314</td><td>35.367</td><td>36.343</td><td>36.359</td></tr><tr><td>62.5</td><td>31.786</td><td>48.926</td><td>35.393</td><td>30.515</td><td>30.499</td></tr></tbody></table>

$$
\hat {Y} _ {1} = 3. 7 7 6 5 + 0. 7 2 2 4 X
$$

$$
\hat {Y} _ {2} = - 2 2. 2 0 8 5 + 1. 9 1 7 8 X - 0. 0 1 5 9 X ^ {2}
$$

$$
\hat {Y} _ {3} = 1 6. 8 6 3 4 - 2. 1 7 2 7 X + 0. 1 0 6 0 X ^ {2} - 0. 0 0 1 1 X ^ {3}
$$

$$
\begin{array}{l} \mathrm {Y} _ {4} = 1 6. 4 3 7 4 - 2. 1 1 1 5 \mathrm {X} + 0. 1 0 3 0 \mathrm {X} ^ {2} - 0. 0 0 1 0 \mathrm {X} ^ {3} \\ + 3. 7 2 4 9 \times 1 0 ^ {- 7} X ^ {4} \\ \end{array}
$$

(2) 计算出各方程式的剩余平方和 $l_{XX} = \sum (\mathrm{Y} - \hat{\mathrm{Y}})^2$. 先计算出从上列方程式而得的回归值 $\hat{\mathrm{Y}}$, 算出各个 $l_{XA}$. 接着计算与上个剩余平方和之差 (表3).

<div align="center">

表3 先后两个方程式剩余平方和之差

</div>

<table><thead><tr><th></th><th>Y</th><th>$\hat{Y}_1$</th><th>$\hat{Y}_2$</th><th>$\hat{Y}_3$</th><th>$\hat{Y}_4$</th></tr></thead><tbody><tr><td>$\Sigma(Y - \hat{Y}_1)^2$</td><td>1.763.307*</td><td>328.249</td><td>191.927</td><td>78.566</td><td>78.564</td></tr><tr><td>剩余平方和的减少</td><td></td><td>1435.056</td><td>136.277</td><td>113.406</td><td>0.002</td></tr><tr><td>$\Sigma(Y - \hat{Y}_1)^2$ /(n-i-1)</td><td></td><td>36.472</td><td>23.987</td><td>11.224</td><td>13.094</td></tr></tbody></table>

* 为 $\sum (\mathrm{Y} - \bar{\mathrm{Y}})^{2},\mathrm{i}$ 为多项式最高项次数，n为样本含量，(n- i-1)为剩余平方和自由度

(3) 剩余平方和减少的方差分析。在连续多项式方程式中，每增加一个高次项，则剩余平方和损失一个自由度；即剩余平方和减少的值占一个自由度，它表示增加一个高次项后拟合精确度的增加。如果这增加值无显著性，说明新增个高次项无必要。现将这增加值（即剩余平方和减少值）作F检验。见表4。

<div align="center">

表4 剩余平方和减少值的方差分析

</div>

<table><thead><tr><th>多项式最高指数i</th><th>1</th><th>2</th><th>3</th><th>4</th></tr></thead><tbody><tr><td>剩余平方和减少值</td><td>1435.056</td><td>136.277</td><td>113.406</td><td>0.002 0</td></tr><tr><td>剩余均方</td><td>36.472</td><td>23.997</td><td>11.224</td><td>13.094 0</td></tr><tr><td>F</td><td>59.800</td><td>5.678</td><td>10.104</td><td>0.000 1</td></tr><tr><td>F(α,i,n-i-i)</td><td>5.120</td><td>5.320</td><td>5.540</td><td>5.990 0</td></tr></tbody></table>

从表4可以看出四次多项式（最高一项指数为4）已无必要，用三次多项式已可。

## 曲线拟合的优度

曲线拟合的优度就是成对的数据库用一个曲线模型予以拟合时的符合的程度，也即应变量Y的实际观察值与通过所拟合的模型计算得到的相应估计值Y的接近程度。这一接近程度，可用决定系数来表示。

曲线拟合优度及其检验步骤如下：

决定系数的计算 有以下几种：

(1) 从曲线回归方程式计算出与各实际观察值 $Y$ 相应的估计值 $\hat{Y}$ 。计算出离均差平方和或算总平方和SS$_{\mathrm{SS}} = \sum (\mathrm{Y} - \hat{\mathrm{Y}})^{2}$ 和剩余平方和SS剩余（SS剩余 $= \sum (\mathrm{Y} - \hat{\mathrm{Y}})^{2}$）。

(2) 计算出决定系数 $ R^{2} $

$$
R ^ {2} = 1 - \frac {\mathrm {S S} _ {\text {剩 余}}}{\mathrm {S S} _ {\text {总}}} = 1 - \frac {\sum \left(Y - \hat {Y}\right) ^ {2}}{\sum \left(Y - \bar {Y}\right) ^ {2}}
$$

$\mathrm{R}^{2}$ 愈接近1，表示Y与 $ \mathrm{\hat{Y}} $愈接近，拟合优度高。

拟合优度的假设检验 曲线回归方程式的拟合常用直线化变换方法，这时拟合优度检验是较简单，可采用它的直线回归方程式进行方差分析，假设检验转化为直线回归方程式中回归系数的检验，即原假设 $\mathrm{H}_0: \beta = 0$；备择假设 $\mathrm{H}_1: \beta \neq 0$。

(1) 将原始数据用直线化方法作曲线拟合，因而拟合过程中可得直线回归方程式：

$$
y = a + b x
$$

上式中，x,y是直线回归中的一对变量，至少其中之一为原来变量的变换后的新变量b为它的回归系数。从变量x,y，计算出y的总平方和SS$\alpha$，回归平方和SS回归及剩余平方和SS剩余。

$$
S S _ {\text {总}} = \sum (y - \bar {y}) ^ {2}
$$

$$
\mathrm {S S} _ {\mathrm {同 口}} = \sum \left(\hat {y} - \bar {y}\right) ^ {2}
$$

$$
\mathrm {S S} _ {\mathrm {网 条}} = \sum \left(y - \hat {y}\right) ^ {2}
$$

(2) 作直线回归的方差分析。原假设为 $\mathrm{H}_0: \beta = 0$ 。从上一步所得数据，按表1作方差分析。

<div align="center">

表1 直线回归方差分析

</div>

<table border="1"><tr><td>变异来源</td><td>平方和</td><td>自由度</td><td>均方</td><td>F</td></tr><tr><td>回归</td><td>SS回归</td><td>1</td><td>MS回归-SS回归1</td><td>F=MS回归/MS剩余</td></tr><tr><td>剩余</td><td>SS剩余</td><td>n-2</td><td>MS剩余-SS剩余n-2</td><td></td></tr><tr><td>总</td><td>SS总</td><td>n-1</td><td></td><td></td></tr></table>

表1中，n为样本含量，所得的F值，与F临界值表中 $ F_{\mathrm{e}(1,n)} $相比，从P是否小于0.05，得拒绝或接受原假设 $ \mathrm{H}_{0} $的结论。

如果结论为拒绝原假设H。即表示回归系数b是显著的，也即表示，所用的曲线模型对实测数据的拟合是适合的。

拟合优度的比较 当一个有双变量的资料用两个不同类型的血线模型来描述X、Y关系，可得到两个曲线回归方程式。两个曲线方程式哪一个更适合原数据，可比较它们的决定系数，决定系数的数值较大的一般认为更合适。

例 在条日“指数曲线拟合”中的例1.

用指数曲线 $\mathrm{Y} = 0.34069\mathrm{e}^{0.07509x}$ 拟合15—55岁男性高血压年龄患病率，试求其决定系数 $(\mathrm{R}^2)$ 并进行拟合优度的显著性检验。

$$
\begin{array}{l} \sum (\mathrm {Y} - \bar {\mathrm {Y}}) ^ {2} - (0. 7 8 - 1. 2 8 7 9) ^ {2} + (2. 1 9 - 1. 8 8 3 2) ^ {2} + \dots \\ + (1 3. 3 8 - 1 2. 5 8 8 0) ^ {2} + (1 8. 4 9 - 1 8. 4 0 6 3) ^ {2} \\ = 2. 7 0 0 2 1 3 \\ \end{array}
$$

$$
\begin{array}{l} \Sigma (Y - \bar {Y}) ^ {2} = \Sigma Y - \frac {\left(\sum Y\right) ^ {2}}{n} = 6 5 0. 6 7 5 - \frac {5 5 . 3 7 ^ {2}}{8} \\ = 2 6 7. 4 4 5 3 6. 7 \\ \end{array}
$$

$$
R ^ {2} = 1 - \frac {\sum \left(Y - \bar {Y}\right) ^ {2}}{\sum \left(Y - \bar {Y}\right) ^ {2}} - 1 - \frac {2 . 7 0 0 2 1 3}{2 6 7 . 4 4 5 3 8 7 5} = 0. 9 8 9 9
$$

由于直线化过程中，作了 $y = \ln Y$ 的变换。得直线回归方程式：

$$
\mathrm {Y} = - 1. 0 7 6 7 8 + 0. 0 7 5 9 9 \mathrm {X},
$$

$$
\bar {y} = (0. 2 4 8 5 + 0. 7 8 3 9 + \dots + 2. 5 9 3 8 + 2. 9 1 7 2) / 8
$$

$$
= 1. 5 8 2 8 7 5
$$

$$
\begin{array}{l} \mathrm {S S} \left| \mathrm {w} \right| - \sum \left(\dot {y} \cdot \dot {y}\right) ^ {2} = (0. 2 5 3 0 4 5 - 1. 5 8 2 8 7 5) ^ {2} + (0. 6 3 2 9 9 5 \\ - 1. 5 8 2 8 7 5) ^ {2} + \dots + (2. 5 3 2 7 4 5 1. 5 8 2 8 7 5) ^ {2} \\ - (2. 9 1 2 6 95 - 1. 5 8 2 8 7 5) ^ {2} \\ - 6. 0 6 3 2 0 4 \\ \end{array}
$$

<table><thead><tr><th>X</th><td>17.5</td><td>22.5</td><td>27.5</td><td>32.5</td><td>37.5</td><td>42.5</td><td>47.5</td><td>52.5</td></tr></thead><tbody><tr><td>$\hat{y}$</td><td>0.253 045</td><td>0.632 995</td><td>1 012 945</td><td>1.392 895</td><td>1.772 845</td><td>2.152 795</td><td>2.532 745</td><td>2.912 695</td></tr></tbody></table>

$$
\begin{array}{l} \mathrm {S S} \text {总} = \sum \left(y - \bar {y}\right) ^ {2} = \sum y ^ {2} - \frac {\left(\sum y\right) ^ {2}}{n} = 2 6. 2 1 0 4 - \frac {1 2. 6 6 3 ^ {2}}{8} \\ = 6. 1 6 6 4 5 4 \\ \mathrm {S S} \text {销 余} = \mathrm {S S} \text {总} - \mathrm {S S} \text {回 归} = 0. 1 0 3 2 5 \\ \end{array}
$$

<div align="center">

表2 方差分项表（检验 $ \mathrm{H}_{0}:\beta = 0 $）

</div>

<table border="1"><tr><td>变异来源</td><td>平方和</td><td>自由度</td><td>均方</td><td>F值</td><td>P值</td></tr><tr><td>回归</td><td>6.063204</td><td>1</td><td>6.063204</td><td>3523.0703</td><td>&lt;0.01</td></tr><tr><td>剩余</td><td>0.10325</td><td>6</td><td>0.001721</td><td></td><td></td></tr><tr><td>总变异</td><td>6.166454</td><td>7</td><td></td><td></td><td></td></tr></table>

$$
F _ {[ 1 6 0. 0 1} = 1 3. 7
$$

由于表2F检验极显著，故用指数曲线米拟合这批数据是合适的。

## logistic曲线拟合

logistic曲线拟合(logistic curve fitting)是对双变量实测数据用一个对称于拐点的S形的曲线（称为logistic曲线，图1）来进行拟合，并用所拟合的曲线回归式来描述两变量的关系。logistic曲线方程式为

$$
Y - L = \frac {K}{1 + a e ^ {b x}}
$$

式中X，Y为一对变量，K，L是这条曲归线的上、下两条渐近线的纵坐标。a,b为所拟合的曲线的常数,e为自然对数的底。

![](page=28,bbox=[86, 770, 407, 964])

<div align="center">

图1 logistic曲线

</div>

式(1)的拐点 $X_{0}Y_{0}$，在此曲线的 $-\frac{\mathrm{lna}}{b},\frac{\mathrm{K}}{2} +L$处），也即在上、下两渐近线相隔的中间。

拟合的方法，一般将式(1)通过变量变换后得到直线式，用直线化法拟合。由式(1)，可得

$$
\frac {K}{Y - L} = 1 + a e ^ {b X}
$$

$$
\frac {K - (Y - L)}{Y - L} = a \cdot e ^ {b \lambda}
$$

$$
\ln \frac {\mathrm {K} - (\mathrm {Y} - \mathrm {L})}{\mathrm {Y} - \mathrm {L}} = \ln \mathrm {a} + \mathrm {b X}
$$

以 $Z = \ln \frac{\mathrm{K} - (\mathrm{Y} - \mathrm{L})}{\mathrm{Y} - \mathrm{L}}$ 对Y作变换，并使A-1na，则式(2)成为

$$
Z = A + b X
$$

拟合步骤：

(1) 将实测的成对X、Y值在方格纸上制散点图（图2），根据各点趋向观察是否呈对称于拐点的S形状，并选定适当的K值与L值。

(2) 对Y作变换，得新变Z值

$$
Z = \ln \frac {\mathrm {K} - (\mathrm {Y} - \mathrm {L})}{\mathrm {Y} - \mathrm {L}}
$$

(3) 将各个(X、Z)值，点在方格纸上制图（图3），观察是否呈直线趋势。如有弯曲，可用尝试法对K、L数值略作调整，使达到呈现直线趋势，得最后的K、L数值及新变量Z数值。

(4) 用一般直线回归方法得式（3）直线回归中的A与b值。logistic曲线中的a用下式得到：

$$
a = e ^ {A}
$$

最后可得如式(1)的logistic曲线。

例 某县1980—1984年15—85岁女性胃癌年龄别死亡率见表中第(2)、(3)列试将此资料用logistic曲线拟合。

<div align="center">

胃癌年龄别死亡率(10万人口)拟合logistic曲线中值计算过程

</div>

<table><thead><tr><th>年龄组 (1)</th><th>组中值 (X) (2)</th><th>胃癌年龄别死亡率 (Y) (3)</th><th>Z=ln<sub>220-Y</sub>/Y (4)</th><th>Ŷ (5)</th></tr></thead><tbody><tr><td>15—</td><td>17.5</td><td>0.30</td><td>6.596 2</td><td>0.218</td></tr><tr><td>20—</td><td>22.5</td><td>0.70</td><td>5.747 1</td><td>0.477</td></tr><tr><td>25—</td><td>27.5</td><td>0.73</td><td>5.705 0</td><td>1.044</td></tr><tr><td>30—</td><td>32.5</td><td>3.36</td><td>4.166 2</td><td>2.277</td></tr><tr><td>35—</td><td>37.5</td><td>6.18</td><td>3.543 8</td><td>4.931</td></tr><tr><td>40—</td><td>42.5</td><td>15.13</td><td>2.605 6</td><td>10.530</td></tr><tr><td>45—</td><td>47.5</td><td>16.84</td><td>2.490 2</td><td>21.840</td></tr><tr><td>50—</td><td>52.5</td><td>26.69</td><td>1.980 0</td><td>42.815</td></tr><tr><td>55—</td><td>57.5</td><td>46.40</td><td>1.319 5</td><td>76.188</td></tr><tr><td>60—</td><td>62.5</td><td>79.26</td><td>0.574 1</td><td>118.218</td></tr><tr><td>65—</td><td>67.5</td><td>90.99</td><td>0.348 8</td><td>157.966</td></tr><tr><td>70—</td><td>72.5</td><td>173.59</td><td>-1.319 0</td><td>186.579</td></tr><tr><td>75—</td><td>77.5</td><td>214.42</td><td>-3.649 6</td><td>203.383</td></tr><tr><td>80—85</td><td>82.5</td><td>217.51</td><td>-4.465 4</td><td>212.096</td></tr></tbody></table>

(1) 将 X, Y 点在方格纸上，得图 2。各点连线略呈 S形。用目测法选定 $l$：下渐近线，得 $K = 220, L = 0$。

![](page=29,bbox=[78, 154, 365, 402])

<div align="center">

图2 某县各年龄组胃癌死亡率（1980-1984）

</div>

(2) 对Y按式（4）作变换，得各组的Z值，列于表的第4列。

(3) 将各个（X，Z）值在方格纸上制图如图3。各点呈现直线趋势。

![](page=29,bbox=[74, 515, 346, 772])

<div align="center">

图3 各年龄组X与胃癌死亡率的变换值Y用直线回归拟合

</div>

(4) 将表中的X（第2列），Z（第4列）作直线回归分析。得：相关系数 $ r = 0.9770 $

$$
A = 9. 6 6 2 8, \text {从式 (5) 得} a = 1 5 7 2 1. 7 5,
$$

$$
b = - 0. 1 5 6 6 。
$$

将a,b,L,K数值代入式（1），得

$$
\hat {\Upsilon} = \frac {1}{1 + 1 5} \frac {2 2 0}{7 2 1 . \overline {{7 5 e}} ^ {- 0 . 1 5 7 x}}
$$

从上式，计算出各年龄组的 $ \uparrow $值，列于表的第5列。

从以上计算得到的a, b值，可计算出拐点的 $ \mathrm{X}_{0},\mathrm{Y}_{0} $值。

$$
X _ {0} = - \frac {\ln a}{b} = - \frac {9 . 6 6 2 8}{0 . 1 5 7} = 6 1. 5
$$

$$
Y _ {0} = \frac {K}{2} + L = \frac {2 2 0}{2} + 0 = 1 1 0
$$

该条曲线在拐点处的Y值上升最快，即61岁前后。胃癌死亡率很快上升。

## 协方差分析

协方差分析(analysis of covariance)是把直线回归法与方差分析法结合起来的一种方法。当对两个或两个以上组的均数 $\bar{Y}$ 作比较时，如果X（称协变量）在各组中的分布不平衡，而且对Y有影响，那么，各组 $\bar{Y}$ 的不同可能是由于X的不平衡所致。为了排除这种可能，宜先作一个回归，求出取 $\bar{X}$ 时各样本的修正均数 $\bar{Y}_c$，再作各 $\bar{Y}_c$。差别的显著性检验。

例如，研究分别以两种饲料喂养的两组幼鼠的体重增加(Y)有否差别，而体重增加又与各个动物的进食量(X)有关。两组幼鼠的进食量在实验时未加控制，因此两组动物进食量不一定相同。在评价两种饲料本身对体重增加的作用，应考虑消除进食量不同的影响，分析出不同饲料营养价值。协方差分析就是用回归方法得出应变量Y（如体重增加）随协变量X（如进食量）而变化的回归方程式。进而计算出当进食量一致时（如都进食X量）各个动物增加的体重 $(Y + \mathrm{残})$ ，这变量而得计算体重为修正值 $Y_{\mathrm{c}}$ 。将各组动物的修正值用方差分析方法作比较。

协方差分析是以各对比组变量Y呈正态分布、方差齐性、回归系数相等为前提的。回归方程式限于线性，协变量X一般限于1-2个。

如果Y与X呈非线性关系，协变量多于2个，则可用非线性多元回归方程式来代替直线回归，计算出各组的修正值或残差值，用t检验或方差分析方法进行检验。

分析时先用目测方法，观察X、Y之间是否虽直线回归关系。顺便观察一下，对比组之间协变量X是否平衡。并注意数据是否符合上述条件，如大致符合，可用下列步骤：

(1) 分别计算各组的X、Y、变量之和 $\sum X_{i}, \sum Y_{i}$ （i表示第i组），平方和 $\sum X_{i}^{2}, \sum Y_{i}^{2}$，乘积之和 $\sum X_{i} Y_{i}$。计算所有变量的总和 $\sum X, \sum Y, \sum XY$。

(2) 计算总变异的离均差平方和 $ \mathrm{l_{xx},l_{yy}} $及离均差乘积和：

$$
I _ {X X (\text {承})} = \sum X ^ {2} - \frac {\left(\sum X\right) ^ {2}}{N}
$$

$$
l _ {Y Y (\mathrm {总})} = \sum Y ^ {2} - \frac {(\sum Y) ^ {2}}{N}
$$

$$
1 _ {X Y (\text {总})} = \sum X Y - \frac {(\sum X) (\sum Y)}{N}.
$$

式中N为各组样本含量的总和， $\sum X, \sum Y, \sum XY$ 为各组X、Y、XY的总和。它们的自由度为N-1。

(3) 计算各对比组间的离均差平方和、乘积和及其自由度；

$$
l _ {X X (\text {原 码})} = \sum_ {i = 1} ^ {k} \frac {\left(\sum X _ {i}\right) ^ {2}}{n _ {i}} - \frac {\left(\sum X\right) ^ {2}}{N}.
$$

$$
I _ {V Y (\text {侧 间})} = \sum_ {i = 1} ^ {k} \frac {\left(\sum Y _ {i}\right) ^ {2}}{n _ {i}} - \frac {\left(\sum X\right) ^ {2}}{N}
$$

$$
I _ {X Y (\text {斜 间})} = \sum_ {i = 1} ^ {k} \frac {\left(\sum X _ {i}\right) \left(\sum Y _ {i}\right)}{n _ {i}} - \frac {\left(\sum X\right) \left(\sum Y\right)}{N}
$$

$$
自由度 = k - 1
$$

式中 $\sum \mathrm{X}_1, \sum \mathrm{Y}_1, \sum \mathrm{X}_1\mathrm{Y}_1$ 分别为第i组的变量之和与乘积和。n为第i组样本含量，k为对比组的组数。

(4) 计算组内的离均差平方和、乘积和及其自由度：

$$
I _ {X X (\text {组 内})} = I _ {X X (\text {总})} - I _ {X X (\text {组 外})}
$$

$$
\mathrm {l} _ {\mathrm {Y Y} (\text {组 内})} = \mathrm {l} _ {\mathrm {Y Y} (\text {总})} - \mathrm {l} _ {\mathrm {Y Y} (\text {组 内})}
$$

$$
l _ {X Y (\text {组 内})} = l _ {X Y (\text {总})} - l _ {X Y (\text {组 则})}
$$

自由度（组内） $=$ 自由度（总）一自由度（组间） $= N - k$ 。

(5) 计算总的，组内的剩余平方和 $\sum (\mathrm{Y} - \hat{\mathrm{Y}})^{2}$ 及其自由度：

$$
\text {总 的 剩 余 平 方 和} = \mathrm {l} _ {\mathrm {Y Y} (\text {总})} - \frac {\mathrm {l} _ {\mathrm {X Y} (\text {总})} ^ {2}}{\mathrm {l} _ {\mathrm {X X} ^ {-} (\text {总})}}
$$

$$
\mathrm {自 由 度} = N - 2
$$

$$
\text {组 内 剩 余 平 方 和} = \mathrm {I} _ {\mathrm {Y Y} (\text {细 内})} - \frac {\mathrm {I} _ {\mathrm {X Y}} ^ {2} (\text {内 内})}{\mathrm {I} _ {\mathrm {X X} ^ {-}} (\text {细 内})}
$$

$$
\text {自由度} = N - k - 1
$$

(6) 计算修正均数间的剩余平方和：

修正均数间剩余平方和 = 总剩余平方和一组内剩余平方和, (12)

$$
自由度 = k - 1
$$

(7) 计算F值：

$$
F = \frac {\text {修 正 均 数 间 的 剩 余 平 方 和} / (k - 1)}{\text {组 内 剩 余 平 方 和} / (N - k - 1)}
$$

查 $ \mathrm{F}_{0.05},(\mathrm{k - 1}),(\mathrm{N - k - 1}) $值与F比较。如 $ \mathrm{P} < 0.05 $，得各对比组的修正均数有显著差别的结论。

(8) 如各对比组修正均数有显著差别，则作各组修正均数的两两比较。

先用下式算出各组修正值的均数 $Y_{1}$

$$
\bar {Y} _ {1} ^ {\prime} = \bar {Y} _ {1} - b _ {\mathrm {c}} \left(\bar {X} _ {1} - \bar {X}\right)
$$

式中 $\overline{X}_1, \overline{Y}_1$ 为第i组X、Y的均数， $\overline{X}$ 为X的总均数。 $b_{c}$ 为公共回归系数；

$$
\mathrm {b} _ {\mathrm {c}} = \mathrm {l} _ {\mathrm {X Y} (\text {组 内})} / \mathrm {l} _ {\mathrm {X X} (\text {组 内})}
$$

得各组的修正均数后，作任两个修正均数 $ \overline{Y}_{\mathrm{A}}^{\prime},\overline{Y}_{\mathrm{B}}^{\prime} $的比较，可用q检验（Newman-Keuls检验）：

$$
q = \frac {Y _ {A} - Y _ {B}}{\sqrt {\frac {\text {组 内 剩 余 方 差}}{n _ {0}} \left[ 1 + - \frac {l _ {X X} (\text {倒 射})}{(a - 1) \left[ l _ {X X} (\text {倒 射}) \right]} \right]}}
$$

式中 $\mathrm{Y}_A, \mathrm{Y}_B$ 为两组修正均数，组内剩余方差为式(11)中组内剩余平方和除其自由度。 $n_0$ 为每组平均含量， $kxx$ （组数）， $kxx$ （组内）得自式（4）、式（7）。a为对比的两组均数包含的组数（包括A、B两组在内）。q的临界值查附录四表20，计算所得的q值与之相比，即可得出结论。

例 男性 I 期砂肺病人和健康工人的肺活量见表 I（肺活量已对身高作校正），请回答 I 期砂肺病人的肺活量是否低于健康

人。

<div align="center">

表丨【期矽肺病人和健康工人的年龄和肺活量

</div>

<table border="1"><tr><td rowspan="2"></td><td colspan="2">1期矽肺</td><td colspan="2">健康工人</td></tr><tr><td>年龄(X1)</td><td>肺活量(Y1)</td><td>年龄(X2)</td><td>肺活量(Y2)</td></tr><tr><td></td><td>50</td><td>3450</td><td>35</td><td>4000</td></tr><tr><td></td><td>53</td><td>3430</td><td>38</td><td>3750</td></tr><tr><td></td><td>54</td><td>3300</td><td>35</td><td>3900</td></tr><tr><td></td><td>48</td><td>3800</td><td>52</td><td>3400</td></tr><tr><td></td><td>53</td><td>3450</td><td>40</td><td>3600</td></tr><tr><td></td><td>55</td><td>3250</td><td>33</td><td>4100</td></tr><tr><td></td><td>60</td><td>3200</td><td>29</td><td>4250</td></tr><tr><td></td><td>50</td><td>3600</td><td>37</td><td>3850</td></tr><tr><td></td><td>47</td><td>3950</td><td>41</td><td>3600</td></tr><tr><td></td><td>62</td><td>3200</td><td>50</td><td>3600</td></tr><tr><td></td><td>52</td><td>3450</td><td>55</td><td>3300</td></tr><tr><td></td><td>63</td><td>3150</td><td>60</td><td>3200</td></tr><tr><td>ΣX</td><td>647</td><td></td><td>505</td><td></td></tr><tr><td>ΣY</td><td></td><td>41230</td><td></td><td>44550</td></tr><tr><td>ΣX2</td><td>35189</td><td></td><td>22303</td><td></td></tr><tr><td>ΣY4</td><td></td><td>142329900</td><td></td><td>166537500</td></tr><tr><td>ΣXY</td><td></td><td>2210390</td><td></td><td>1841900</td></tr><tr><td>X</td><td>53.9</td><td></td><td>42.1</td><td></td></tr><tr><td>Y</td><td></td><td>3435.8</td><td></td><td>3712.5</td></tr></table>

(1) 计算各变量之和 $\sum X, \sum Y$ ，平方和 $\sum X^2, \sum Y^2$ 及积和 $\sum XY$ ，见表1下平部。

(2) 计算总变异的离均芳平方和 $ \mathrm{l_{xx}},\mathrm{l_{yy}}, $积和 $ \mathrm{l_{xy}} $及自由度 $ \nu_{0} $ （表2）：

$$
\begin{array}{l} \mathrm {l} _ {\mathrm {X X}} - \sum \mathrm {X} ^ {2} - \frac {(\sum \mathrm {X}) ^ {2}}{\mathrm {N}} = 5 7 4 9 2 - \frac {(1 1 5 2) ^ {2}}{2 4} = 2 1 9 6 \\ \mathrm {l} _ {\mathrm {Y Y}} - \sum \mathrm {Y} ^ {2} - \frac {(\sum \mathrm {Y}) ^ {2}}{\mathrm {N}} = 3 0 8 8 6 7 4 0 0 - \frac {(8 5 7 8 0) ^ {2}}{2 4} = 2 2 7 5 3 8 3 \\ \mathrm {l} _ {\mathrm {X Y}} - \sum \mathrm {X Y} - \frac {\sum \mathrm {Y} \sum \mathrm {X}}{\mathrm {N}} = 4 0 5 2 2 9 0 - \frac {(8 5 7 8 0) (1 1 5 2)}{2 4} \\ = - 6 5 1 5 0 \\ \nu = 2 4 - 1 = 2 3 \\ \end{array}
$$

再计算各处理组间的离均差平方和，积和及自由度（表2）；组间；

$$
\begin{array}{l} \mathrm {I} _ {\mathrm {x x}} = \sum \frac {\left(\sum \mathrm {Y} _ {i}\right) ^ {2}}{\mathrm {n} _ {i}} - \frac {\left(\sum \mathrm {X}\right) ^ {2}}{\mathrm {N}} = \frac {6 4 7 ^ {2} + 5 0 5 ^ {2}}{1 2} - \frac {(1 1 5 2) ^ {2}}{2 4} = 8 4 0 \\ \mathrm {I} _ {\mathrm {y y}} = \sum \frac {\left(\sum \mathrm {Y} _ {i}\right) ^ {2}}{\mathrm {n} _ {i}} - \frac {\left(\sum \mathrm {Y}\right) ^ {2}}{\mathrm {N}} = \frac {4 1}{1 2} \frac {2 3 0 ^ {2}}{1 2} + \frac {4 4}{1 2} 5 5 0 ^ {2}. \\ - \frac {(8 5 7 8 0) ^ {2}}{2 4} = 4 5 9 2 6 6. 7 \\ \end{array}
$$

$$
\begin{array}{l} l _ {X Y} = \sum \frac {\left(\sum X _ {i}\right) \left(\sum Y _ {i}\right)}{m} - \frac {\left(\sum X\right) \left(\sum Y\right)}{N} \\ = \frac {6 4 7 \times 4 1}{1 2} \frac {2 3 0 + 5 0 5}{1 2} \times \frac {4 4}{5 5 0} - \frac {1}{1 2} \frac {1 5 2 \times 8 5}{2 4} \frac {7 8 0}{2 4} \\ = - 1 9 6 4 3. 3 \\ \nu = 2 - 1 = 1 \\ \end{array}
$$

(3) 利用总的离差平方和、组间离差平方和求组内的离差平方和（表2）.

<div align="center">

表2 表1资料的协方差分析

</div>

<table><thead><tr><th rowspan="2">变异来源</th><th colspan="4">离均差平方和及积和</th><th colspan="3">剩余</th></tr><tr><th>ν</th><th>l<sub>xx</sub></th><th>l<sub>xy</sub></th><th>l<sub>yy</sub></th><th>ν</th><th>Σ(Y - Î̂)²</th><th>MS</th></tr></thead><tbody><tr><td>总</td><td>23</td><td>2 196</td><td>-65 150</td><td>2 275 383</td><td>22</td><td>342 540.33</td><td></td></tr><tr><td>组间</td><td>1</td><td>840</td><td>-19 643.3</td><td>459 266.7</td><td></td><td></td><td></td></tr><tr><td>组内</td><td>22</td><td>1 356</td><td>-45 506.7</td><td>1 816 116.3</td><td>21</td><td>288 933.597</td><td>137 587</td></tr><tr><td>修正均数间</td><td></td><td></td><td></td><td></td><td>1</td><td>53 606.7</td><td>53 606.7</td></tr></tbody></table>

(4) 求剩余平方和 $\sum (Y - \hat{Y})^2$ ，自由度 $v$ ，均方SM及F值（表2）；

$$
\begin{array}{l} \sum \left(\mathrm {Y} - \hat {\mathrm {Y}}\right) ^ {2} = 2 2 7 5 3 8 3 - \frac {(6 5 1 5 0) ^ {2}}{2 1 9 6} = 3 4 2 5 4 0. 3 3 1 \\ v = 2 3 - 1 = 2 2 \\ \end{array}
$$

组内 $\sum (\mathrm{Y} - \hat{\mathrm{Y}})^{2} = 18161163 - \frac{(45506.7)^{2}}{1356} = 288933.597$ $\nu = 22 - 1 = 21$

$$
\mathrm {M S} = 2 8 8 9 3 3. 5 9 7 \div 2 1 = 1 3 7 5 8. 7
$$

修正均数间：

$$
\sum \left(Y - \hat {Y}\right) ^ {2} = 3 4 2 5 4 0. 3 3 - 2 8 8 9 3 3. 6 = 5 3 6 0 6. 7
$$

$$
v = 2 2 - 2 1 = 1
$$

$$
\mathrm {M S} = 5 3 6 0 6. 7 / 1 = 5 3 6 0 6. 7
$$

$$
F = 5 3 6 0 6. 7 \div 1 3 7 5 8. 7 = 3. 8 9 6
$$

查F界值表（附录四表19）， $ F_{04}(1, 121) = 4. 32 $因为， $ F = 3. 896 < F_{04}(1, 121) $所以 $ P > 0. 05 $说明在平衡了年龄之后，I期砂肺患者与健康工人的肺活量没有显著差别。

## 多变量统计

## 主成分分析

当用p个指标描述n个个体时，这些指标之间往往存在相关关系。在信息损失较少的前提下，由原指标综合成彼此独立数目较少的 $m(\mathrm{m} \leqslant p)$ 个新的指标（主成分），以代替原来的数目较多的p个指标的分析方法称为主成分分析(principal component analysis)。结合专业知识可逐个分析各主成分所代表的实际意义。

身高和体重两个指标，表示了儿童的大小。而这些儿童的

设有n个儿童，测得身高 $(X_{1})$ 及体重 $(X_{2})$ 两个指标。$X_{1}$ 与 $X_{2}$ 高度相关。若以 $X_{1}$ 为横轴， $X_{2}$ 为纵轴，用n个对象的数据作散点图。可以发现这些点散布在一条直线的近旁（见图）。若以此直线作为新坐标轴 $z_{1}$，再取与 $z_{1}$ 垂直的线作为新坐标轴 $z_{2}$。在 $z_{1}, z_{2}$ 平面上，由n个点的分布可见，$z_{2}$ 值不随 $z_{1}$ 值的变化而变化，即 $z_{1}$ 和 $z_{2}$ 不相关；而且n个点的变异主要反应在 $z_{1}$ 方向上，这些点的 $z_{2}$ 值变化很小。所以研究这几个对象的变异，可以只考虑 $z_{1}$ 值的大小，而忽略 $z_{2}$ 值的差异。由图可见，$z_{1}$ 值大的儿童一般其身高体重数值都大，$z_{1}$ 值小则相反，因而 $z_{1}$ 值综合了儿童

![](page=31,bbox=[524, 789, 737, 959])

<div align="center">

两指标主成分分析示意图

</div>

$z_{2}$ 大小差不多，且 $z_{1}$ 的大小与 $z_{2}$ 的大小无关。统计学上称 $z_{2}$ 为 $X_{1}, X_{2}$ 的第一主成分，$z_{2}$ 为 $X_{1}, X_{2}$ 的第二主成分。这种分析方法为主成分分析法。

一般对n个对象图像p个指标，可以得到np个数据。

如表1所示，只要p个指标间存在关系，就可以通过一定的数学方法找到一组新指标 $z_{i}, \dots, z_{p_i}$ 它们满足。

(1) $ z_{1},\dots ,z_{p} $是原指标的线性函数，且它们相互

垂直。

(2) $ z_{1},\dots ,z_{p} $互不相关。

(3) $z_{1},\dots ,z_{p}$ 提供原指标所含的全部信息，且 $z_{1}$ 提供的信息最多， $z_{2}$ 其次， $\dots z_{p}$ 最少。

主成分分析可分为R型及Q型两种，按指标主成分时为R型主成分分析。按个体研究主成分则为Q型主成分分析。其中以R型主成分分析比较常用。

计算步骤如下：

(1) 收集数据列成表1形式。

<div align="center">

表1 原始数据表

</div>

<table><thead><tr><th rowspan="2">对象号</th><th colspan="4">指标</th></tr><tr><th>X<sub>1</sub></th><th>X<sub>2</sub></th><th>...</th><th>X<sub>p</sub></th></tr></thead><tbody><tr><td>1</td><td>X<sub>11</sub></td><td>X<sub>12</sub></td><td>...</td><td>X<sub>1p</sub></td></tr><tr><td>2</td><td>X<sub>21</sub></td><td>X<sub>22</sub></td><td>...</td><td>X<sub>2p</sub></td></tr><tr><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr><tr><td>n</td><td>X<sub>n1</sub></td><td>X<sub>n2</sub></td><td>...</td><td>X<sub>np</sub></td></tr></tbody></table>

(2) 作标准化变换：

$$
y _ {1} = \frac {X _ {1} - \bar {X} _ {1}}{S _ {1}}
$$

(3) 计算相关系数 $ r_{ij} $ （ $ i=1\cdots p; j=1\cdots p $ ）:

$$
r _ {i j} = \frac {\sum y _ {i} y _ {j}}{n - 1}
$$

(4) 求方程

$$
\left| \begin{array}{c c c} r _ {1 1} - \lambda & r _ {1 2} & \dots r _ {1 p} \\ r _ {2 1} & r _ {2 2} - \lambda & \dots r _ {2 p} \\ \vdots & & \vdots \\ r _ {n 1} & r _ {n 2} & \dots r _ {n n} - \lambda \end{array} \right| = 0
$$

的D个根，即特征根，且将它们从大到小排列

$$
\lambda_ {1} \geqslant \lambda_ {2} \dots \geqslant \lambda_ {p}
$$

(5) 求特征向量 $ \mathrm{l}_{10} $及各主成分 $ \mathrm{z}_{1}\dots \mathrm{z}_{p} $

$$
\left\{ \begin{array}{l} r _ {1 1} l _ {1 1} + r _ {1 2} l _ {1 2} + \dots + r _ {1 p} l _ {1 p} = \lambda_ {1} l _ {1 1} \\ r _ {2 1} l _ {1 1} + r _ {2 2} l _ {1 2} + \dots + r _ {2 p} l _ {1 p} = \lambda_ {1} l _ {1 2} \\ \vdots \\ r _ {p 1} l _ {1 1} + r _ {p 2} l _ {1 2} + \dots + r _ {p p} l _ {1 p} = \lambda_ {1} l _ {1 p} \\ l _ {1 1} ^ {2} + l _ {1 2} ^ {2} + \dots + l _ {1 p} ^ {2} = 1 \end{array} \right.
$$

解

得 $ \mathrm{l}_{11},\mathrm{l}_{12},\dots ,\mathrm{l}_{1p} $ ，则第一主成分为

$$
z _ {1} = l _ {1 1} y _ {1} + \dots + l _ {1 p} y _ {p}
$$

$$
\mathrm {且} \mathrm {s} _ {z 1} ^ {2} = \lambda_ {1}
$$

(6) 再解方程组

$$
\left[ \begin{array}{c c c} r _ {1 1} l _ {1 1} + r _ {1 2} l _ {2 2} + \dots + r _ {1 p} l _ {2 p} = \lambda_ {1} l _ {2 p} \\ r _ {2 1} l _ {2 1} + r _ {2 2} l _ {2 2} + \dots + r _ {2 p} l _ {2 p} = \lambda_ {2} l _ {2 p} \\ \vdots & \vdots \\ r _ {p 1} l _ {2 1} + r _ {p 2} l _ {2 2} + \dots + r _ {p p} l _ {2 p} = \lambda_ {2} l _ {2 p} \\ l _ {2} ^ {0} + l _ {2} ^ {2} + \dots + l _ {2} ^ {p} = 1 \\ l _ {1 1} l _ {2 1} + l _ {1 2} l _ {2 2} + \dots + l _ {1 p} l _ {2 p} = 0 \end{array} \right.
$$

得 $ \mathrm{l}_{2 1},\mathrm{l}_{2 2}\cdots \mathrm{l}_{2 p} $则第二主成分为

且 $ S_{z2}^{2}=\lambda_{2} $

$$
z _ {2} = l _ {2 1} y _ {1} + \dots + l _ {2 p} y _ {p}
$$

(7) 解下列方程：

$$
\left\{ \begin{array}{l} r _ {1 1} l _ {1 1} + r _ {1 2} l _ {2 2} + \dots + r _ {1 p} l _ {p p} = \lambda_ {3} l _ {3 1} \\ r _ {2 1} l _ {1 1} + r _ {2 2} l _ {2 2} + \dots + r _ {2 p} l _ {p p} = \lambda_ {3} l _ {3 2} \\ \vdots \quad \vdots \\ r _ {p 1} l _ {1 1} + r _ {p 2} l _ {2 2} + \dots + r _ {p p} l _ {p p} = \lambda_ {3} l _ {3 p} \\ l _ {1} ^ {2} + l _ {2} ^ {2} + \dots + l _ {p} ^ {2} = 1 \\ l _ {1 1} l _ {1 1} + l _ {1 2} l _ {2 2} + \dots + l _ {1 p} l _ {p p} = 0 \\ l _ {1 1} l _ {1 1} + l _ {2 2} l _ {2 2} + \dots + l _ {p p} l _ {p p} = 0 \end{array} \right.
$$

得 $ \mathrm{l}_{31},\mathrm{l}_{32}\cdots \mathrm{l}_{3\mathrm{p}} $ ，则第三主成分为

$$
\begin{array}{l} z _ {3} = \left| _ {3 1} y _ {1} + \dots + \right| _ {3 p} y _ {p} \\ \mathrm {S} _ {Z _ {3}} ^ {2} = \lambda_ {3} \\ \end{array}
$$

耳

(8) 依此求第四、五……主成分。

(9) 最后得 $ \mathrm{l}_{p1},\mathrm{l}_{p2}\dots \mathrm{l}_{pp} $ ，则第p个主成分为

$$
z _ {p} = \mathrm {l} _ {p 1} y _ {1} + \dots + \mathrm {l} _ {p p} y _ {p}
$$

$$
S _ {Z _ {p}} ^ {2} = \lambda_ {p}
$$

(10) 求主成分的贡献率。指标所提供的信息量可由方差度量。标准化后（为消除单位影响）原指标所提供的信息量为

$ s_{y1}^{2} + s_{y2}^{2} + \dots + s_{yp}^{2} = p_{0} z_{1} (i = 1, \dots , p) $所提供的信息量为

$$
s _ {7 1} ^ {2} = \frac {\sum \left(z _ {1} - \bar {z} _ {1}\right) ^ {2}}{n - 1}
$$

因 $ \bar{z}_{1}=0 $所以

$$
s _ {z i} ^ {2} = \frac {\sum z _ {i} ^ {2}}{n - 1}
$$

将每个体的 $z_{i}$ 值代入求 $z_{i}$ 的公式求得各 $z_{i}$ 值，再由式(8)求得各 $s_{zi}^2$ 值。同样可得

$$
\sum \mathrm {s} _ {2 1} ^ {2} = \sum \lambda_ {1} = \mathrm {p}
$$

$\frac{\lambda_{i}}{p}$ （ $j=1\dots p$ ）为第i个主成分的贡献率

$\sum_{i=1}^{m} \frac{\lambda_{i}}{p}$ 表示前m个主成分的累计贡献率

由于前面的n个主成分贡献率较大，说明仅少数几个主成分已提供了绝大部分的信息，这样就可以以少量的主成分来描述个体特征而损失很少的信息。

主成分分析的实际意义是，如以身高 $(\mathrm{X}_1)$ 及体重 $(\mathrm{X}_2)$ 资料作主要成分分析，并得第一主成分两个系数都是正的，说明 $Z_{1}$ 表示了儿童的大小，$Z_{2}$ 越大则儿童越高越重。$z_{2}$ 的第一个系数（体重）是负的，第二个系数是正的，则表示第二主成分越大，儿童越瘦长。且 $s_{2}^{2}$ 远大于 $s_{2}^{2}_{x}$，表示儿童大小之间差异较大，而体型差异不大。多指标分析时也一样，要根据各主成分中系数的正负号及数值大小，再结合业务知识，判断各主成分的实际意义。

例 某防疫站对该地区72名14岁男生检测了下列12个指标，试对他们生长发育状况作出综合评价。

<div align="center">