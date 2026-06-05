import AdminLayout from "@/components/AdminLayout";
import { useEffect, useState } from "react";
import { useTranslation } from "react-i18next";
import { stats as statsApi } from "@/lib/api";
import { useToast } from "@/hooks/use-toast";
import { Card } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import {
  BarChart,
  Bar,
  PieChart,
  Pie,
  Cell,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  ResponsiveContainer,
  LineChart,
  Line,
} from "recharts";
import {
  TrendingUp,
  Users,
  GraduationCap,
  Zap,
  Target,
  BookOpen,
} from "lucide-react";

const COLORS = [
  "#3b82f6", // blue
  "#10b981", // green
  "#f59e0b", // amber
  "#ef4444", // red
  "#8b5cf6", // purple
  "#ec4899", // pink
  "#06b6d4", // cyan
  "#14b8a6", // teal
];

const AdminStatistics = () => {
  const { t } = useTranslation();
  const { toast } = useToast();
  const [loading, setLoading] = useState(true);
  const [statsData, setStatsData] = useState<any>(null);

  useEffect(() => {
    const fetchStats = async () => {
      try {
        setLoading(true);
        const response = await statsApi.getDashboard() as any;
        setStatsData(response.stats || response);
      } catch (error) {
        toast({
          title: t("common.error"),
          description: t("admin.pages.statistics.loadingError"),
          variant: "destructive",
        });
        console.error("Error fetching stats:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchStats();
  }, [toast]);

  if (loading) {
    return (
      <AdminLayout>
        <div className="flex items-center justify-center min-h-screen">
          <p className="text-muted-foreground">{t("common.loading")}</p>
        </div>
      </AdminLayout>
    );
  }

  const tauxParFiliere = (statsData?.tauxParFiliere || [])
    .slice(0, 12)
    .map((item: any) => ({
      name: item.nom?.substring(0, 20) || "Filière",
      taux: parseInt(item.taux) || 0,
      pourcentage: item.pourcentage || 0,
    }));

  const repartitionSeries = (statsData?.repartitionSeries || []).map(
    (item: any) => ({
      name: item.serie || "N/A",
      value: parseInt(item.nombre_utilisateurs) || 0,
      percentage: item.pourcentage || 0,
    })
  );

  const topFilieres = (statsData?.topFilieres || []).slice(0, 8);

  const repartitionDomaines = (statsData?.repartitionDomaines || []).map(
    (item: any) => ({
      name: item.domaine || "Autre",
      value: parseInt(item.nombre_filieres) || 0,
      percentage: item.pourcentage || 0,
    })
  );

  const statCards = [
    {
      label: "Total Utilisateurs",
      value: statsData?.totalUsers || 0,
      icon: Users,
      color: "bg-blue-100 text-blue-600",
    },
    {
      label: "Filières Disponibles",
      value: statsData?.totalFilieres || 0,
      icon: GraduationCap,
      color: "bg-green-100 text-green-600",
    },
    {
      label: "Universités",
      value: statsData?.totalUniversites || 0,
      icon: BookOpen,
      color: "bg-purple-100 text-purple-600",
    },
    {
      label: "Recommandations",
      value: statsData?.totalRecommendations || 0,
      icon: Zap,
      color: "bg-amber-100 text-amber-600",
    },
    {
      label: "Taux Moyen Compatibilité",
      value: `${statsData?.tauxCompatibiliteMoyen || 0}%`,
      icon: TrendingUp,
      color: "bg-pink-100 text-pink-600",
    },
  ];

  return (
    <AdminLayout>
      <div className="animate-fade-in space-y-8">
        {/* Header */}
        <div>
          <h1 className="text-4xl font-bold">Statistiques Avancées</h1>
          <p className="mt-1 text-muted-foreground">
            Analyse détaillée des recommandations et profils utilisateurs
          </p>
        </div>

        {/* KPI Cards */}
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-5">
          {statCards.map((stat, idx) => {
            const Icon = stat.icon;
            return (
              <Card key={idx} className="p-6 flex flex-col">
                <div className="flex items-start justify-between mb-4">
                  <div>
                    <p className="text-sm text-muted-foreground mb-1">
                      {stat.label}
                    </p>
                    <p className="text-3xl font-bold">{stat.value}</p>
                  </div>
                  <div className={`p-3 rounded-lg ${stat.color}`}>
                    <Icon className="h-6 w-6" />
                  </div>
                </div>
              </Card>
            );
          })}
        </div>

        {/* Main Charts Grid */}
        <div className="grid gap-8 lg:grid-cols-2">
          {/* Taux de Recommandation par Filière */}
          <Card className="p-6">
            <div className="mb-6">
              <h2 className="text-lg font-semibold flex items-center gap-2">
                <Target className="h-5 w-5 text-primary" />
                Taux de Recommandation par Filière (Top 12)
              </h2>
              <p className="text-xs text-muted-foreground mt-1">
                Nombre de fois que chaque filière a été recommandée
              </p>
            </div>
            {tauxParFiliere.length > 0 ? (
              <ResponsiveContainer width="100%" height={300}>
                <BarChart data={tauxParFiliere} margin={{ top: 20, right: 30, left: 0, bottom: 80 }}>
                  <CartesianGrid strokeDasharray="3 3" stroke="#e5e7eb" />
                  <XAxis
                    dataKey="name"
                    angle={-45}
                    textAnchor="end"
                    height={100}
                    tick={{ fontSize: 11 }}
                  />
                  <YAxis tick={{ fontSize: 11 }} />
                  <Tooltip
                    contentStyle={{
                      borderRadius: "8px",
                      border: "1px solid #e5e7eb",
                      fontSize: "12px",
                    }}
                    formatter={(value: any) => [value, "Recommandations"]}
                  />
                  <Bar dataKey="taux" fill="#3b82f6" radius={[4, 4, 0, 0]} />
                </BarChart>
              </ResponsiveContainer>
            ) : (
              <div className="h-80 flex items-center justify-center text-muted-foreground">
                Pas de données disponibles
              </div>
            )}
          </Card>

          {/* Répartition par Série Bac */}
          <Card className="p-6">
            <div className="mb-6">
              <h2 className="text-lg font-semibold flex items-center gap-2">
                <Users className="h-5 w-5 text-primary" />
                Répartition des Utilisateurs par Série Bac
              </h2>
              <p className="text-xs text-muted-foreground mt-1">
                Distribution des profils académiques
              </p>
            </div>
            {repartitionSeries.length > 0 ? (
              <div className="flex gap-8">
                <ResponsiveContainer width="60%" height={300}>
                  <PieChart>
                    <Pie
                      data={repartitionSeries}
                      cx="50%"
                      cy="50%"
                      innerRadius={60}
                      outerRadius={100}
                      paddingAngle={2}
                      dataKey="value"
                    >
                      {repartitionSeries.map((entry: any, index: number) => (
                        <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                      ))}
                    </Pie>
                    <Tooltip
                      formatter={(value: any) => [value, "Utilisateurs"]}
                      contentStyle={{
                        borderRadius: "8px",
                        border: "1px solid #e5e7eb",
                        fontSize: "12px",
                      }}
                    />
                  </PieChart>
                </ResponsiveContainer>
                <div className="flex-1 space-y-2">
                  {repartitionSeries.map((item: any, idx: number) => (
                    <div key={idx} className="text-sm">
                      <div className="flex items-center gap-2 mb-1">
                        <div
                          className="w-3 h-3 rounded-full"
                          style={{
                            backgroundColor: COLORS[idx % COLORS.length],
                          }}
                        />
                        <span className="font-medium">{item.name}</span>
                      </div>
                      <p className="text-xs text-muted-foreground ml-5">
                        {item.value} utilisateurs ({item.percentage}%)
                      </p>
                    </div>
                  ))}
                </div>
              </div>
            ) : (
              <div className="h-80 flex items-center justify-center text-muted-foreground">
                Pas de données disponibles
              </div>
            )}
          </Card>

          {/* Filières Populaires */}
          <Card className="p-6">
            <div className="mb-6">
              <h2 className="text-lg font-semibold flex items-center gap-2">
                <TrendingUp className="h-5 w-5 text-primary" />
                Top 8 Filières Recommandées
              </h2>
              <p className="text-xs text-muted-foreground mt-1">
                Filières avec le meilleur taux de recommandation
              </p>
            </div>
            {topFilieres.length > 0 ? (
              <div className="space-y-3">
                {topFilieres.map((filiere: any, idx: number) => (
                  <div
                    key={filiere.id}
                    className="rounded-lg border bg-card p-3 hover:bg-muted/50 transition-colors"
                  >
                    <div className="flex items-center justify-between mb-2">
                      <div className="flex items-center gap-3">
                        <div className="flex h-8 w-8 items-center justify-center rounded-full bg-primary/10 text-sm font-bold text-primary">
                          {idx + 1}
                        </div>
                        <div>
                          <p className="text-sm font-medium">{filiere.nom}</p>
                          <p className="text-xs text-muted-foreground">
                            {filiere.domaine || "Domaine non spécifié"}
                          </p>
                        </div>
                      </div>
                      <div className="text-right">
                        <Badge variant="outline" className="mb-1">
                          {filiere.taux_recommandation} recommandations
                        </Badge>
                        <p className="text-xs text-muted-foreground">
                          Score: {filiere.score_moyen || "N/A"}/10
                        </p>
                      </div>
                    </div>
                    <div className="w-full bg-muted h-2 rounded-full overflow-hidden">
                      <div
                        className="bg-primary h-full transition-all"
                        style={{
                          width: `${Math.min(
                            ((filiere.taux_recommandation || 0) /
                              Math.max(...topFilieres.map((f: any) => f.taux_recommandation || 0))) *
                              100,
                            100
                          )}%`,
                        }}
                      />
                    </div>
                  </div>
                ))}
              </div>
            ) : (
              <div className="h-64 flex items-center justify-center text-muted-foreground">
                Pas de données disponibles
              </div>
            )}
          </Card>

          {/* Répartition par Domaine */}
          <Card className="p-6">
            <div className="mb-6">
              <h2 className="text-lg font-semibold flex items-center gap-2">
                <BookOpen className="h-5 w-5 text-primary" />
                Répartition par Domaine
              </h2>
              <p className="text-xs text-muted-foreground mt-1">
                Distribution des filières par domaine académique
              </p>
            </div>
            {repartitionDomaines.length > 0 ? (
              <ResponsiveContainer width="100%" height={300}>
                <PieChart>
                  <Pie
                    data={repartitionDomaines}
                    cx="50%"
                    cy="50%"
                    outerRadius={100}
                    paddingAngle={1}
                    dataKey="value"
                    label={({ name, percentage }) => `${name} (${percentage}%)`}
                  >
                    {repartitionDomaines.map((entry: any, index: number) => (
                      <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                    ))}
                  </Pie>
                  <Tooltip
                    formatter={(value: any) => [value, "Filières"]}
                    contentStyle={{
                      borderRadius: "8px",
                      border: "1px solid #e5e7eb",
                      fontSize: "12px",
                    }}
                  />
                </PieChart>
              </ResponsiveContainer>
            ) : (
              <div className="h-80 flex items-center justify-center text-muted-foreground">
                Pas de données disponibles
              </div>
            )}
          </Card>
        </div>

        {/* Summary Stats */}
        <Card className="p-6">
          <h2 className="text-lg font-semibold mb-4">Résumé des Profils Utilisateurs</h2>
          <div className="grid gap-4 sm:grid-cols-3">
            <div className="rounded-lg border bg-muted/20 p-4">
              <p className="text-sm text-muted-foreground mb-1">Moyenne Générale Moyenne</p>
              <p className="text-2xl font-bold">
                {statsData?.profilsNiveaux?.moyenne_generale_moyenne || "N/A"}
                <span className="text-sm text-muted-foreground">/20</span>
              </p>
            </div>
            <div className="rounded-lg border bg-muted/20 p-4">
              <p className="text-sm text-muted-foreground mb-1">Budget Mensuel Moyen</p>
              <p className="text-2xl font-bold">
                {statsData?.profilsNiveaux?.budget_moyen
                  ? `${Math.round(statsData.profilsNiveaux.budget_moyen).toLocaleString('fr-FR')} Ar`
                  : "N/A"}
              </p>
            </div>
            <div className="rounded-lg border bg-muted/20 p-4">
              <p className="text-sm text-muted-foreground mb-1">Total Utilisateurs Analysés</p>
              <p className="text-2xl font-bold">
                {statsData?.profilsNiveaux?.nombre_utilisateurs || 0}
              </p>
            </div>
          </div>
        </Card>
      </div>
    </AdminLayout>
  );
};

export default AdminStatistics;
