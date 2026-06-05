import AdminLayout from "@/components/AdminLayout";
import { Progress } from "@/components/ui/progress";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Card } from "@/components/ui/card";
import {
  Users,
  GraduationCap,
  ClipboardCheck,
  TrendingUp,
  BarChart3,
  Activity,
  UserPlus,
  Download,
  FileText,
  Sheet,
  Target,
  BookOpen,
  Zap,
} from "lucide-react";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
  DropdownMenuSeparator,
} from "@/components/ui/dropdown-menu";
import {
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
  LineChart,
  Line,
  PieChart,
  Pie,
  Cell,
  Legend,
} from "recharts";
import { useEffect, useState } from "react";
import { useTranslation } from "react-i18next";
import { stats as statsApi, admin, universities, filieres } from "@/lib/api";
import { exportStatsSummary, downloadCSV, downloadPDF } from "@/lib/export";
import { useToast } from "@/hooks/use-toast";
import { useTheme } from "@/hooks/use-theme";

const PIE_COLORS = [
  "#3b82f6",
  "#10b981",
  "#f59e0b",
  "#ef4444",
  "#8b5cf6",
  "#ec4899",
  "#06b6d4",
  "#14b8a6",
];

const AdminOverview = () => {
  const { toast } = useToast();
  const { theme } = useTheme();
  const { t } = useTranslation();
  const [loading, setLoading] = useState(true);
  const [statsData, setStatsData] = useState<any>(null);
  const [recentUsers, setRecentUsers] = useState<any[]>([]);
  const [topFields, setTopFields] = useState<any[]>([]);
  const [activityData, setActivityData] = useState<any[]>([]);
  const [monthlyData, setMonthlyData] = useState<any[]>([]);
  const [pieData, setPieData] = useState<any[]>([]);
  const [allUsers, setAllUsers] = useState<any[]>([]);
  const [tauxParFiliere, setTauxParFiliere] = useState<any[]>([]);
  const [repartitionSeries, setRepartitionSeries] = useState<any[]>([]);
  const [topFilieres, setTopFilieres] = useState<any[]>([]);
  const [repartitionDomaines, setRepartitionDomaines] = useState<any[]>([]);

  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);

        // Fetch dashboard statistics
        const dashboardStats = await statsApi.getDashboard() as any;
        const stats = dashboardStats.stats || dashboardStats;
        setStatsData(stats);

        // Process detailed statistics from dashboard
        const tauxFiliere = (stats?.tauxParFiliere || [])
          .slice(0, 12)
          .map((item: any) => ({
            name: item.nom?.substring(0, 20) || "Filière",
            taux: parseInt(item.taux) || 0,
            pourcentage: item.pourcentage || 0,
          }));
        setTauxParFiliere(tauxFiliere);

        const repartSeries = (stats?.repartitionSeries || []).map((item: any) => ({
          name: item.serie || "N/A",
          value: parseInt(item.nombre_utilisateurs) || 0,
          percentage: item.pourcentage || 0,
        }));
        setRepartitionSeries(repartSeries);

        const topFil = (stats?.topFilieres || []).slice(0, 9);
        setTopFilieres(topFil);

        const repartDomaines = (stats?.repartitionDomaines || []).map((item: any) => ({
          name: item.domaine || "Autre",
          value: parseInt(item.nombre_filieres) || 0,
          percentage: item.pourcentage || 0,
        }));
        setRepartitionDomaines(repartDomaines);

        // Fetch all users for export
        const allUsersData = await admin.getUsers(1, 100) as any;
        if (allUsersData.users) {
          const formattedUsers = allUsersData.users.map((user: any) => ({
            id: user.id,
            name: `${user.prenom || ''} ${user.nom || ''}`.trim(),
            email: user.email,
            role: user.role === 'admin' ? 'Admin' : 'Étudiant',
            serie: user.serie_bac || '-',
            status: user.actif ? 'Actif' : 'Inactif',
            date: new Date(user.createdAt || user.date_creation).toLocaleDateString('fr-FR'),
          }));
          setAllUsers(formattedUsers);
          setRecentUsers(formattedUsers.slice(0, 5));
        }

        // Fetch all fields for statistics
        const fieldsData = await filieres.getAll() as any;
        if (fieldsData.filieres) {
          // Group by domain and calculate percentages
          const grouped = fieldsData.filieres.reduce((acc: any, field: any) => {
            const domain = field.domaine || 'Autre';
            acc[domain] = (acc[domain] || 0) + 1;
            return acc;
          }, {});

          const total = fieldsData.filieres.length;
          const topFieldsList = Object.entries(grouped)
            .map(([name, count]: [string, any]) => ({
              name,
              percentage: Math.round((count / total) * 100),
            }))
            .sort((a, b) => b.percentage - a.percentage)
            .slice(0, 6);

          setTopFields(topFieldsList);
        }

        // Fetch universities count
        const universitiesData = await universities.getAll();

        // Generate mock activity and monthly data based on fetched stats
        const mockActivity = [
          { day: "Lun", inscriptions: 12, tests: 8 },
          { day: "Mar", inscriptions: 19, tests: 14 },
          { day: "Mer", inscriptions: 15, tests: 11 },
          { day: "Jeu", inscriptions: 22, tests: 18 },
          { day: "Ven", inscriptions: 28, tests: 21 },
          { day: "Sam", inscriptions: 14, tests: 9 },
          { day: "Dim", inscriptions: 8, tests: 5 },
        ];
        setActivityData(mockActivity);

        const mockMonthly = [
          { month: "Sep", users: 180 },
          { month: "Oct", users: 420 },
          { month: "Nov", users: 650 },
          { month: "Déc", users: 890 },
          { month: "Jan", users: 1250 },
          { month: "Fév", users: ((dashboardStats as any)?.stats?.totalUsers || 1523) },
        ];
        setMonthlyData(mockMonthly);

        // Generate pie data for bac series distribution
        const mockPie = [
          { name: "Série C", value: 38 },
          { name: "Série D", value: 28 },
          { name: "Série A", value: 18 },
          { name: "Tech.", value: 16 },
        ];
        setPieData(mockPie);
      } catch (error) {
        console.error('Error fetching dashboard data:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  const gridColor = theme === "dark" ? "#3f3f46" : "#e5e7eb";
  const textColor = theme === "dark" ? "#d4d4d8" : "#374151";

  const statItems = [
    { label: t("admin.totalUsers"), value: statsData?.totalUsers || "0", icon: Users, color: "bg-blue-100 text-blue-600 dark:bg-blue-900/40 dark:text-blue-400" },
    { label: t("admin.availableFields"), value: statsData?.totalFilieres || "0", icon: GraduationCap, color: "bg-green-100 text-green-600 dark:bg-green-900/40 dark:text-green-400" },
    { label: t("admin.universities"), value: statsData?.totalUniversites || "0", icon: BookOpen, color: "bg-purple-100 text-purple-600 dark:bg-purple-900/40 dark:text-purple-400" },
    { label: t("admin.recommendations"), value: statsData?.totalRecommendations || "0", icon: Zap, color: "bg-amber-100 text-amber-600 dark:bg-amber-900/40 dark:text-amber-400" },
    { label: t("admin.averageCompatibility"), value: `${statsData?.tauxCompatibiliteMoyen || "0"}%`, icon: TrendingUp, color: "bg-pink-100 text-pink-600 dark:bg-pink-900/40 dark:text-pink-400" },
  ];

  const handleExportStats = () => {
    if (statsData) {
      exportStatsSummary(statsData, `statistiques-${new Date().toLocaleDateString('fr-FR')}.csv`);
      toast({ title: t("common.success"), description: t("admin.exportStats") + " ✓" });
    }
  };

  const handleExportUsers = () => {
    if (allUsers.length > 0) {
      const data = allUsers.map(u => ({
        ID: u.id,
        Nom: u.name,
        Email: u.email,
        Rôle: u.role,
        'Série Bac': u.serie,
        Statut: u.status,
        'Date Inscription': u.date,
      }));
      downloadCSV(data, `utilisateurs-${new Date().toLocaleDateString('fr-FR')}.csv`);
      toast({ title: t("common.success"), description: t("admin.exportUsers") + " ✓" });
    }
  };

  const handleExportPDF = () => {
    const columns = [
      { key: 'Métrique', label: 'Métrique' },
      { key: 'Valeur', label: 'Valeur' },
    ];
    const data = [
      { Métrique: 'Utilisateurs inscrits', Valeur: statsData?.totalUsers || 0 },
      { Métrique: 'Tests complétés', Valeur: statsData?.totalRecommendations || 0 },
      { Métrique: 'Filières disponibles', Valeur: statsData?.totalFilieres || 0 },
      { Métrique: 'Taux de satisfaction', Valeur: `${statsData?.tauxCompatibiliteMoyen || 0}%` },
    ];
    downloadPDF('Rapport Statistiques', data, columns);
    toast({ title: t("common.success"), description: t("admin.exportReport") + " ✓" });
  };

  if (loading) {
    return (
      <AdminLayout>
        <div className="flex items-center justify-center min-h-screen">
          <p className="text-muted-foreground">{t("common.loading")}</p>
        </div>
      </AdminLayout>
    );
  }

  return (
    <AdminLayout>
      <div className="animate-fade-in space-y-8">
        <div className="mb-8 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
          <div>
            <h1 className="text-4xl font-bold">{t("admin.dashboard")}</h1>
            <p className="mt-1 text-muted-foreground">
              {t("admin.statistics")}
            </p>
          </div>
          <DropdownMenu>
            <DropdownMenuTrigger asChild>
              <Button size="sm" variant="outline">
                <Download className="h-4 w-4 mr-2" /> {t("common.export")}
              </Button>
            </DropdownMenuTrigger>
            <DropdownMenuContent align="end">
              <DropdownMenuItem onClick={handleExportStats}>
                <Sheet className="h-4 w-4 mr-2" /> {t("admin.exportStats")}
              </DropdownMenuItem>
              <DropdownMenuItem onClick={handleExportUsers}>
                <Sheet className="h-4 w-4 mr-2" /> {t("admin.exportUsers")}
              </DropdownMenuItem>
              <DropdownMenuSeparator />
              <DropdownMenuItem onClick={handleExportPDF}>
                <FileText className="h-4 w-4 mr-2" /> {t("admin.exportReport")}
              </DropdownMenuItem>
            </DropdownMenuContent>
          </DropdownMenu>
        </div>

        {/* KPI Cards */}
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-5">
          {statItems.map((stat) => (
            <div key={stat.label} className="rounded-2xl border border-border bg-card p-6 shadow-sm hover:shadow-md transition-shadow">
              <div className="flex items-start justify-between">
                <div className="flex-1">
                  <p className="text-xs sm:text-sm text-muted-foreground font-medium mb-2">{stat.label}</p>
                  <p className="text-2xl sm:text-3xl font-bold text-foreground">{typeof stat.value === 'number' ? stat.value.toLocaleString() : stat.value}</p>
                </div>
                <div className={`flex h-12 w-12 items-center justify-center rounded-xl ${stat.color} shrink-0`}>
                  <stat.icon className="h-6 w-6" />
                </div>
              </div>
            </div>
          ))}
        </div>

        {/* Activity and Growth Charts */}
        <div className="grid gap-8 lg:grid-cols-2">
          <Card className="p-6">
            <h2 className="text-lg font-semibold flex items-center gap-2 mb-4">
              <Activity className="h-5 w-5 text-primary" />
              {t("admin.weeklyActivity")}
            </h2>
            <ResponsiveContainer width="100%" height={240}>
              <BarChart data={activityData}>
                <CartesianGrid strokeDasharray="3 3" stroke={gridColor} />
                <XAxis dataKey="day" tick={{ fontSize: 12, fill: textColor }} />
                <YAxis tick={{ fontSize: 12, fill: textColor }} />
                <Tooltip contentStyle={{ borderRadius: "8px", border: `1px solid ${gridColor}`, fontSize: "12px", backgroundColor: theme === "dark" ? "#27272a" : "#ffffff", color: textColor }} />
                <Legend />
                <Bar dataKey="inscriptions" fill="#3b82f6" radius={[4, 4, 0, 0]} name="Inscriptions" />
                <Bar dataKey="tests" fill="#10b981" radius={[4, 4, 0, 0]} name="Tests" />
              </BarChart>
            </ResponsiveContainer>
          </Card>

          <Card className="p-6">
            <h2 className="text-lg font-semibold flex items-center gap-2 mb-4">
              <TrendingUp className="h-5 w-5 text-primary" />
              {t("admin.userGrowth")}
            </h2>
            <ResponsiveContainer width="100%" height={240}>
              <LineChart data={monthlyData}>
                <CartesianGrid strokeDasharray="3 3" stroke={gridColor} />
                <XAxis dataKey="month" tick={{ fontSize: 12, fill: textColor }} />
                <YAxis tick={{ fontSize: 12, fill: textColor }} />
                <Tooltip contentStyle={{ borderRadius: "8px", border: `1px solid ${gridColor}`, fontSize: "12px", backgroundColor: theme === "dark" ? "#27272a" : "#ffffff", color: textColor }} />
                <Legend />
                <Line type="monotone" dataKey="users" stroke="#3b82f6" strokeWidth={2.5} dot={{ r: 4, fill: "#3b82f6" }} name="Utilisateurs" />
              </LineChart>
            </ResponsiveContainer>
          </Card>
        </div>

        {/* Detailed Statistics Section */}
        <div className="border-t pt-8">
          <h2 className="text-2xl font-bold mb-6">{t("admin.detailedAnalysis")}</h2>

          <div className="grid gap-8 lg:grid-cols-2">
            {/* Taux de Recommandation par Filière */}
            <Card className="p-6">
              <div className="mb-6">
                <h3 className="text-lg font-semibold flex items-center gap-2">
                  <Target className="h-5 w-5 text-primary" />
                  {t("admin.recommendationRate")}
                </h3>
                <p className="text-xs text-muted-foreground mt-1">{t("admin.topFields")}</p>
              </div>
              {tauxParFiliere.length > 0 ? (
                <ResponsiveContainer width="100%" height={300}>
                  <BarChart data={tauxParFiliere} margin={{ top: 20, right: 30, left: 0, bottom: 80 }}>
                    <CartesianGrid strokeDasharray="3 3" stroke={gridColor} />
                    <XAxis dataKey="name" angle={-45} textAnchor="end" height={100} tick={{ fontSize: 11, fill: textColor }} />
                    <YAxis tick={{ fontSize: 11, fill: textColor }} />
                    <Tooltip contentStyle={{ borderRadius: "8px", border: `1px solid ${gridColor}`, fontSize: "12px", backgroundColor: theme === "dark" ? "#27272a" : "#ffffff", color: textColor }} formatter={(value: any) => [value, "Recommandations"]} />
                    <Bar dataKey="taux" fill="#3b82f6" radius={[4, 4, 0, 0]} />
                  </BarChart>
                </ResponsiveContainer>
              ) : (
                <div className="h-80 flex items-center justify-center text-muted-foreground">{t("common.noData")}</div>
              )}
            </Card>

            {/* Répartition par Série Bac */}
            <Card className="p-6">
              <div className="mb-6">
                <h3 className="text-lg font-semibold flex items-center gap-2">
                  <Users className="h-5 w-5 text-primary" />
                  {t("admin.distributionBySeries")}
                </h3>
                <p className="text-xs text-muted-foreground mt-1">{t("admin.userProfiles")}</p>
              </div>
              {repartitionSeries.length > 0 ? (
                <div className="flex gap-8">
                  <ResponsiveContainer width="60%" height={300}>
                    <PieChart>
                      <Pie data={repartitionSeries} cx="50%" cy="50%" innerRadius={60} outerRadius={100} paddingAngle={2} dataKey="value">
                        {repartitionSeries.map((_, idx) => (
                          <Cell key={`cell-${idx}`} fill={PIE_COLORS[idx % PIE_COLORS.length]} />
                        ))}
                      </Pie>
                      <Tooltip formatter={(value: any) => [value, "Utilisateurs"]} contentStyle={{ borderRadius: "8px", border: `1px solid ${gridColor}`, fontSize: "12px", backgroundColor: theme === "dark" ? "#27272a" : "#ffffff", color: textColor }} />
                    </PieChart>
                  </ResponsiveContainer>
                  <div className="flex-1 space-y-2">
                    {repartitionSeries.map((item, idx) => (
                      <div key={idx} className="text-sm">
                        <div className="flex items-center gap-2 mb-1">
                          <div className="w-3 h-3 rounded-full" style={{ backgroundColor: PIE_COLORS[idx % PIE_COLORS.length] }} />
                          <span className="font-medium">{item.name}</span>
                        </div>
                        <p className="text-xs text-muted-foreground ml-5">{item.value} ({item.percentage}%)</p>
                      </div>
                    ))}
                  </div>
                </div>
              ) : (
                <div className="h-80 flex items-center justify-center text-muted-foreground">{t("common.noData")}</div>
              )}
            </Card>

            {/* Top Filières */}
            <Card className="p-6">
              <div className="mb-6">
                <h3 className="text-lg font-semibold flex items-center gap-2">
                  <TrendingUp className="h-5 w-5 text-primary" />
                  {t("admin.top8Fields")}
                </h3>
                <p className="text-xs text-muted-foreground mt-1">{t("admin.bestRate")}</p>
              </div>
              {topFilieres.length > 0 ? (
                <div className="space-y-3">
                  {topFilieres.map((filiere: any, idx: number) => (
                    <div key={filiere.id} className="rounded-lg border bg-muted/50 p-3 hover:bg-muted/70 transition-colors">
                      <div className="flex items-center justify-between mb-2">
                        <div className="flex items-center gap-3">
                          <div className="flex h-8 w-8 items-center justify-center rounded-full bg-primary/10 text-sm font-bold text-primary">{idx + 1}</div>
                          <div>
                            <p className="text-sm font-medium">{filiere.nom}</p>
                            <p className="text-xs text-muted-foreground">{filiere.domaine}</p>
                          </div>
                        </div>
                        <Badge variant="outline">{filiere.taux_recommandation}</Badge>
                      </div>
                      <div className="w-full bg-muted h-2 rounded-full overflow-hidden">
                        <div className="bg-primary h-full" style={{ width: `${Math.min(((filiere.taux_recommandation || 0) / Math.max(...topFilieres.map((f: any) => f.taux_recommandation || 0))) * 100, 100)}%` }} />
                      </div>
                    </div>
                  ))}
                </div>
              ) : (
                <div className="h-64 flex items-center justify-center text-muted-foreground">Pas de données</div>
              )}
            </Card>

            {/* Répartition par Domaine */}
            <Card className="p-6">
              <div className="mb-6">
                <h3 className="text-lg font-semibold flex items-center gap-2">
                  <BookOpen className="h-5 w-5 text-primary" />
                  {t("admin.domainDistribution")}
                </h3>
                <p className="text-xs text-muted-foreground mt-1">{t("admin.fieldDistribution")}</p>
              </div>
              {repartitionDomaines.length > 0 ? (
                <div className="space-y-4">
                  {/* <ResponsiveContainer width="100%" height={280}>
                    <PieChart>
                      <Pie
                        data={repartitionDomaines}
                        cx="50%"
                        cy="50%"
                        outerRadius={80}
                        paddingAngle={2}
                        dataKey="value"
                        label={false}
                      >
                        {repartitionDomaines.map((_, idx) => (
                          <Cell key={`cell-${idx}`} fill={PIE_COLORS[idx % PIE_COLORS.length]} />
                        ))}
                      </Pie>
                      <Tooltip
                        formatter={(value: any) => [value, "Filières"]}
                        contentStyle={{ borderRadius: "8px", border: `1px solid ${gridColor}`, fontSize: "12px", backgroundColor: theme === "dark" ? "#27272a" : "#ffffff", color: textColor }}
                      />
                    </PieChart>
                  </ResponsiveContainer> */}

                  {/* Legend below chart */}
                  <div className="grid grid-cols-2 gap-2 text-xs">
                    {repartitionDomaines.map((item, idx) => (
                      <div key={idx} className="flex items-center gap-2">
                        <div
                          className="w-3 h-3 rounded-full shrink-0"
                          style={{ backgroundColor: PIE_COLORS[idx % PIE_COLORS.length] }}
                        />
                        <div className="flex-1 min-w-0">
                          <p className="text-gray-700 font-medium truncate">{item.name}</p>
                          <p className="text-muted-foreground">{item.value} ({item.percentage}%)</p>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              ) : (
                <div className="h-80 flex items-center justify-center text-muted-foreground">{t("common.noData")}</div>
              )}
            </Card>
          </div>
        </div>

        {/* User Profiles Summary */}
        <Card className="p-6">
          <h2 className="text-lg font-semibold mb-4">{t("admin.userProfilesSummary")}</h2>
          <div className="grid gap-4 sm:grid-cols-3">
            <div className="rounded-lg border border-border bg-muted p-4">
              <p className="text-sm text-muted-foreground mb-1">{t("admin.averageScore")}</p>
              <p className="text-2xl font-bold text-foreground">{statsData?.profilsNiveaux?.moyenne_generale_moyenne || "N/A"} <span className="text-sm">/20</span></p>
            </div>
            <div className="rounded-lg border border-border bg-muted p-4">
              <p className="text-sm text-muted-foreground mb-1">{t("admin.monthlyBudget")}</p>
              <p className="text-2xl font-bold text-foreground">{statsData?.profilsNiveaux?.budget_moyen ? `${Math.round(statsData.profilsNiveaux.budget_moyen).toLocaleString('fr-FR')} Ar` : "N/A"}</p>
            </div>
            <div className="rounded-lg border border-border bg-muted p-4">
              <p className="text-sm text-muted-foreground mb-1">{t("admin.totalUsersAnalyzed")}</p>
              <p className="text-2xl font-bold text-foreground">{statsData?.profilsNiveaux?.nombre_utilisateurs || 0}</p>
            </div>
          </div>
        </Card>

        <div className="mt-8 rounded-xl border bg-card shadow-card">
          <div className="flex items-center justify-between p-6 border-b">
            <h2 className="text-lg font-semibold flex items-center gap-2">
              <UserPlus className="h-5 w-5 text-primary" />
              {t("admin.recentUsers")}
            </h2>
          </div>
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead>
                <tr className="border-b text-left text-xs font-semibold uppercase tracking-wider text-muted-foreground">
                  <th className="p-4">{t("admin.name")}</th>
                  <th className="p-4">{t("admin.email")}</th>
                  <th className="p-4">{t("admin.date")}</th>
                  <th className="p-4">{t("admin.status")}</th>
                </tr>
              </thead>
              <tbody>
                {recentUsers.length > 0 ? (
                  recentUsers.map((user, i) => (
                    <tr key={i} className="border-b last:border-0 hover:bg-accent/30 transition-colors">
                      <td className="p-4">
                        <div className="flex items-center gap-3">
                          <div className="flex h-8 w-8 items-center justify-center rounded-full bg-accent text-xs font-semibold text-accent-foreground">
                            {user.name.charAt(0)}
                          </div>
                          <span className="text-sm font-medium">{user.name}</span>
                        </div>
                      </td>
                      <td className="p-4 text-sm text-muted-foreground">{user.email}</td>
                      <td className="p-4 text-sm text-muted-foreground">{user.date}</td>
                      <td className="p-4">
                        <span className={`rounded-full px-2.5 py-0.5 text-xs font-medium ${user.status === "Actif" ? "bg-success/10 text-success" : "bg-muted text-muted-foreground"}`}>
                          {user.status}
                        </span>
                      </td>
                    </tr>
                  ))
                ) : (
                  <tr>
                    <td colSpan={4} className="p-8 text-center text-muted-foreground">
                      {t("admin.noUsersFound")}
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </AdminLayout>
  );
};

export default AdminOverview;
