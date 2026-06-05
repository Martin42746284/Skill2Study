import DashboardLayout from "@/components/DashboardLayout";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Link, useParams } from "react-router-dom";
import { useTranslation } from "react-i18next";
import {
  ArrowLeft,
  BarChart3,
  Brain,
  CheckCircle2,
  Target,
  TrendingUp,
  Star,
} from "lucide-react";
import {
  RadarChart,
  PolarGrid,
  PolarAngleAxis,
  PolarRadiusAxis,
  Radar,
  ResponsiveContainer,
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
} from "recharts";

const radarData = [
  { subject: "Scientifique", score: 85, fullMark: 100 },
  { subject: "Littéraire", score: 45, fullMark: 100 },
  { subject: "Technique", score: 78, fullMark: 100 },
  { subject: "Artistique", score: 35, fullMark: 100 },
  { subject: "Social", score: 62, fullMark: 100 },
  { subject: "Commercial", score: 55, fullMark: 100 },
];

const barData = [
  { name: "Informatique", score: 92 },
  { name: "Mathématiques", score: 85 },
  { name: "Physique", score: 78 },
  { name: "Gestion", score: 65 },
  { name: "Droit", score: 42 },
  { name: "Lettres", score: 38 },
];

const topRecommendations = [
  { field: "Génie Logiciel", university: "Université d'Antananarivo", match: 92 },
  { field: "Génie Informatique", university: "IST Antananarivo", match: 89 },
  { field: "Mathématiques Appliquées", university: "Université de Fianarantsoa", match: 85 },
  { field: "Génie Électrique", university: "Université d'Antsiranana", match: 78 },
];

const TestResults = () => {
  const { id } = useParams();

  return (
    <DashboardLayout>
      <div className="animate-fade-in h-full flex flex-col px-4 sm:px-6 lg:px-8 py-6 overflow-hidden">
        <div className="mb-6 shrink-0">
          <Link to="/dashboard/history" className="inline-flex items-center gap-1 text-sm text-muted-foreground hover:text-foreground mb-4">
            <ArrowLeft className="h-4 w-4" />
            Retour à l'historique
          </Link>
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold">Résultats du test</h1>
              <p className="mt-1 text-muted-foreground">
                Test d'orientation scientifique — Complété le 3 mars 2026
              </p>
            </div>
            <Badge className="bg-success/10 text-success border-success" variant="outline">
              <CheckCircle2 className="h-3.5 w-3.5 mr-1" />
              Complété
            </Badge>
          </div>
        </div>

        <div className="flex-1 overflow-y-auto space-y-6 pr-2">
          {/* Score global */}
          <div className="rounded-xl border bg-card p-6 shadow-card">
          <div className="flex flex-col items-center text-center sm:flex-row sm:text-left sm:gap-8">
            <div className="relative mb-4 sm:mb-0">
              <div className="flex h-28 w-28 items-center justify-center rounded-full border-4 border-primary bg-primary/5">
                <div>
                  <p className="text-4xl font-bold text-primary">85</p>
                  <p className="text-xs text-muted-foreground">/100</p>
                </div>
              </div>
            </div>
            <div className="flex-1">
              <h2 className="text-xl font-semibold mb-2">Score global excellent</h2>
              <p className="text-muted-foreground text-sm mb-3">
                Vous avez un profil à dominante scientifique et technique. Vos compétences analytiques
                et votre esprit logique sont des atouts majeurs pour les filières STEM.
              </p>
              <div className="flex flex-wrap gap-2">
                <Badge variant="secondary"><Brain className="h-3 w-3 mr-1" /> Analytique</Badge>
                <Badge variant="secondary"><TrendingUp className="h-3 w-3 mr-1" /> Logique</Badge>
                <Badge variant="secondary"><Target className="h-3 w-3 mr-1" /> Méthodique</Badge>
              </div>
            </div>
          </div>
        </div>

          <div className="grid gap-6 lg:grid-cols-2">
          {/* Radar Chart */}
          <div className="rounded-xl border bg-card p-6 shadow-card">
            <h3 className="text-lg font-semibold mb-4 flex items-center gap-2">
              <BarChart3 className="h-5 w-5 text-primary" />
              Profil de compétences
            </h3>
            <ResponsiveContainer width="100%" height={300}>
              <RadarChart data={radarData}>
                <PolarGrid stroke="hsl(var(--border))" />
                <PolarAngleAxis dataKey="subject" tick={{ fontSize: 12, fill: "hsl(var(--muted-foreground))" }} />
                <PolarRadiusAxis angle={30} domain={[0, 100]} tick={{ fontSize: 10 }} />
                <Radar
                  name="Score"
                  dataKey="score"
                  stroke="hsl(var(--primary))"
                  fill="hsl(var(--primary))"
                  fillOpacity={0.2}
                  strokeWidth={2}
                />
              </RadarChart>
            </ResponsiveContainer>
          </div>

          {/* Bar Chart */}
          <div className="rounded-xl border bg-card p-6 shadow-card">
            <h3 className="text-lg font-semibold mb-4 flex items-center gap-2">
              <TrendingUp className="h-5 w-5 text-primary" />
              Compatibilité par filière
            </h3>
            <ResponsiveContainer width="100%" height={300}>
              <BarChart data={barData} layout="vertical">
                <CartesianGrid strokeDasharray="3 3" stroke="hsl(var(--border))" />
                <XAxis type="number" domain={[0, 100]} tick={{ fontSize: 12 }} />
                <YAxis dataKey="name" type="category" width={100} tick={{ fontSize: 11 }} />
                <Tooltip
                  contentStyle={{
                    backgroundColor: "hsl(var(--card))",
                    border: "1px solid hsl(var(--border))",
                    borderRadius: "8px",
                  }}
                />
                <Bar dataKey="score" fill="hsl(var(--primary))" radius={[0, 4, 4, 0]} />
              </BarChart>
            </ResponsiveContainer>
          </div>
        </div>

          {/* Top Recommendations */}
          <div className="rounded-xl border bg-card p-6 shadow-card">
          <h3 className="text-lg font-semibold mb-4 flex items-center gap-2">
            <Star className="h-5 w-5 text-warning" />
            Filières recommandées
          </h3>
          <div className="space-y-3">
            {topRecommendations.map((rec, i) => (
              <div
                key={i}
                className="flex items-center justify-between rounded-lg border p-4 transition-colors hover:bg-accent/30"
              >
                <div className="flex items-center gap-4">
                  <div className="flex h-9 w-9 items-center justify-center rounded-full bg-primary/10 text-sm font-bold text-primary">
                    {i + 1}
                  </div>
                  <div>
                    <p className="font-semibold text-sm">{rec.field}</p>
                    <p className="text-xs text-muted-foreground">{rec.university}</p>
                  </div>
                </div>
                <div className="flex items-center gap-3">
                  <Badge variant="outline" className="border-primary text-primary font-semibold">
                    {rec.match}% match
                  </Badge>
                  <Link to="/recommendations">
                    <Button variant="outline" size="sm">Voir</Button>
                  </Link>
                </div>
              </div>
            ))}
          </div>
        </div>
        </div>
      </div>
    </DashboardLayout>
  );
};

export default TestResults;
